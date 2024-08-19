<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;
use Auth;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Cache;

class utilityController extends Controller
{
    //
    public function __construct()
    {
        date_default_timezone_set(env('TIME_ZONE'));
        $this->today = date('Y-m-d H:i:s', time());
        $this->curdate=date('Y-m-d', time());
        $this->Appstate=env('APP_LIVE')?env('APP_PRO'):env('APP_DEV');
        $this->AppName=env('APP_NAME');

        $this->otp='1 hours';
      // $this->otp='20 seconds';//test purpose
        $this->email_confirm='24 hours';
        $this->Admin_Auth_error="You Are not authenticate please Request Permission to Admin";
        $this->Admin_Auth_result_error="0";//Admin auth result zero
        $this->platform1=env('PLATFORM3');
    }

    public function validateBuy(){//validate if client has enough amount on his account to buy electricity

    }
    public function placeOrder(){//place electricity Order
        //placeOrder userid=number

/*cardId=,
amount,
convert to $;later
Admin check his amount if is greater than the amount the electricity he want*/
/*must make sure that everything is working expected
admin promotion option later */











    }
    public function ussDBuyElectricity(Request $request){

        $sessionId=$request->input("sessionId");
        $serviceCode=$request->input("serviceCode");
        $phoneNumber=$request->input("phoneNumber");
        $text=$request->input("text");

        if($text=="")
        {
            DB::statement('INSERT INTO tempusers(uid,sessionKey) VALUES (?, ?) ON DUPLICATE KEY UPDATE sessionKey= ?', [$phoneNumber, "0", "0"]);
            $check=DB::select("select token from history_buys where uid=:uid order by id desc limit 1",[
                "uid"=>$phoneNumber
            ]);
              $checkToken=($check)?"2. Voir le Code d'électricité":"";
            $response  = "CON Acheter de l'électricité \n";
             $response .= "1. Acheter \n";
             $response .= $checkToken;
        }

        else if($text=="1"){

            DB::update("update tempusers set sessionKey=:sessionKey where uid=:uid limit 1",[
                "sessionKey"=>"1",
                "uid"=>$phoneNumber
              ]);
            $response  = "CON Entrez votre numéro de compteur \n";


        }
        else if($text=="2"){//view Token

            $check=DB::select("select token from history_buys where uid=:uid order by id desc limit 1",[
                "uid"=>$phoneNumber
            ]);
            if($check){
                $token=$check[0]->token;
                $response  = "CON Votre Code d'électricité est $token \n";
            }

        }
        else{
            $check=DB::select("select sessionKey from tempusers where uid=:uid limit 1",[
                "uid"=>$phoneNumber
            ]);
            if($check[0]->sessionKey=="1"){

                DB::update("update tempusers set sessionKey=:sessionKey,meterNo=:meterNo where uid=:uid limit 1",[
                    "sessionKey"=>"2",
                    "meterNo"=>$text,
                    "uid"=>$phoneNumber
                  ]);
                  $response  = "CON Entrer le montant \n";

            }
            else if($check[0]->sessionKey=="2"){
                $check=DB::select("select meterNo from tempusers where uid=:uid limit 1",[
                    "uid"=>$phoneNumber
                ]);
                $token=mt_rand(10000, 99999)."-".mt_rand(10000, 99999)."-".mt_rand(10000, 99999)."-".mt_rand(10000, 99999);
                DB::table("history_buys")
                ->insert([
                    "uid"=>$phoneNumber,
                    "meterNo"=>$check[0]->meterNo,
                    "token"=>$token,
                    "created_at"=>$this->today
                ]);
                $response  = "CON Votre Code d'électricité est $token \n";
            }
        }
        header('Content-type: text/plain');
        echo $response;

    }


    public function getAccount($input){
        $check=DB::select("select addBalance from admnin_records where uid=:uid limit 1",[
            "uid"=>Auth::user()->uid
        ]);
        if($check){
            return response([
                "status"=>true,
                "result"=>$check,

            ],200);
        }
        else{
            return response([
                "status"=>false,
                "result"=>$check,

            ],200);
        }

    }

    public function utilitySubmitOrder($input){//get Token

        try {
            $check=DB::transaction(function () use ($input) {

                $systemUid=$input['systemUid'];
                $productCode=$input['productCode'];
                $paidStatus="checked";
                $OrderpaidStatus="paid";
                 $inputData=$input['inputData'];//this must be converted to USD
                 $uidCreator=Auth::user()->uid;

                 $productPrice=DB::select("select price,qty,qty_sold from products where subscriber=:subscriber and productCode=:productCode limit 1",array(
                     "productCode"=>$productCode,

                     "subscriber"=>Auth::user()->subscriber
                    ));//validate product price

                    $checkBalance=DB::select("select currency,currencyV from exchanges where currency=:currency limit 1",[
                        'currency'=>$input["currency"]
                    ]);//means is to add currency according to dollars
                    $inputData=$inputData/($checkBalance[0]->currencyV);
                     $AdminBalance=DB::select("select addBalance from admnin_records where uid=:uid and status=:status limit 1",[
                         "uid"=>Auth::user()->uid,
                         "status"=>'Sales'
                     ]);

                     $req_qty=(1/$productPrice[0]->price)*$inputData;
                         $req_qty=floor($req_qty * 100) / 100;
                         //echo $req_qty;
                     if($req_qty<=($productPrice[0]->qty-$productPrice[0]->qty_sold))
                     {


                         //$req_qty=10.2;
                         if($inputData<=$AdminBalance[0]->addBalance)//check admin Balance
                         {


                            if (!$this->InsertUser($input)) return  [
                                "status"=>false,

                                "message"=>"Something Goes Wrong"


                            ];
                             $subscriber=Auth::user()->subscriber;
                             DB::select("SET @requested_qty = ?", [$req_qty]);

                             $results = DB::select("
                                 SELECT
                                     id,
                                     safariId,
                                     CASE
                                         WHEN @requested_qty >= qty THEN qty
                                         ELSE @requested_qty
                                     END AS qty,
                                     CASE
                                         WHEN @requested_qty >= qty THEN 0
                                         ELSE @requested_qty - qty
                                     END AS remaining,
                                     @requested_qty := GREATEST(@requested_qty - qty, 0) AS updated_requested_qty
                                 FROM
                                 safariproducts
                                 WHERE
                                     subscriber='$subscriber' and
                                     productCode='$productCode' AND
                                     qty != 0 AND
                                     @requested_qty > 0
                                 ORDER BY
                                     id;
                             ");


                             $orderId=$input['orderIdFromEdit']??'none';
                             $uid =($orderId=='none')?"UIDM"."_".Str::random(2).""."_".date(time()):$orderId;
                             $data=[];
                             $ids=[];
                               $limitData=count($results);
                             for($i=0;$i<$limitData;$i++)
                             {
                                 $id=$results[$i]->id;
                                 $ids[]=$results[$i]->id;
                                 $data[] = [
                                     //'uid' =>$input["orderIdFromEdit"]??$uid,
                                     'uid' =>$uid,
                                     'userid'=>$input['uidUser'],//card No
                                     'safariId'=>$results[$i]->safariId,
                                     "order_creator"=>Auth::user()->uid,
                                     "ref"=>$input["ref"],
                                     "paidStatus"=>"checked",
                                     "subscriber"=>Auth::user()->subscriber,
                                     'productCode'=>$productCode,
                                     'price'=>$productPrice[0]->price,
                                     'qty'=>$results[$i]->qty,
                                     'qty_count'=>$results[$i]->qty,
                                     'total'=>$results[$i]->qty*$productPrice[0]->price,
                                     'OrderData'=>json_encode([]),
                                     'comment_count'=>json_encode([]),
                                     "created_at"=>$this->today,
                                     "updated_at"=>$this->today


                                     // Add more rows here if needed
                                 ];

                                 $SoldOut=$results[$i]->qty;
                                 $totAm=$SoldOut*$productPrice[0]->price;
                                 $qtyData=abs($results[$i]->remaining);
                                DB::update("update safariproducts set qty=:qty,SoldOut=SoldOut+$SoldOut,TotSoldAmount=TotSoldAmount+$totAm where safariId=:safariId and productCode=:productCode and subscriber=:subscriber limit $limitData",array(
                                "qty"=>$qtyData,
                                "subscriber"=>Auth::user()->subscriber,
                                "safariId"=>$results[$i]->safariId,
                                "productCode"=>$productCode,

                                ));

                             }

                             $checkInsert=DB::table("orderhistories")
                             ->insert($data);
                         if($checkInsert)
                         {
                             $check=DB::update("update products set qty_sold=qty_sold+$req_qty where subscriber=:subscriber and productCode=:productCode and qty>=qty_sold+$req_qty limit 1",array(
                                 "productCode"=>$productCode,
                                 "subscriber"=>Auth::user()->subscriber
                              ));
                             $json_array =  [
                                 [
                                 "uid"=>$uid,//orderId
                                 "total"=>$inputData,
                                 "paid"=>$inputData,
                                 "debt"=>$inputData-$inputData,
                                 "promotionUid"=>$input['uid'],
                                 "reach"=>$input['reach'],
                                 "ref"=>$input["ref"],
                                 "InpuTCurrency"=>$input["currency"],
                                 "gain"=>$input['gain'],
                                 "paidStatus"=>$OrderpaidStatus,
                                 "actionStatus"=>"Created",
                                 "systemUid"=>$systemUid,
                                 "uidUser"=>($input['uidUser']??$uidCreator),
                                 "uidCreator"=>$uidCreator,
                                 "subscriber"=>$subscriber,
                                 "commentData"=>$input['commentData']??'none',
                                 "created_at"=>$this->today,
                                 "updated_at"=>$this->today
                                 ]
                             ];
                             DB::table("orders")
                             ->insert([
                                 "uid"=>$uid,//orderId
                                 "total"=>$inputData,
                                 "paid"=>$inputData,
                                 "debt"=>$inputData-$inputData,
                                 "paidStatus"=>$OrderpaidStatus,
                                 "promotionUid"=>$input['uid'],
                                 "reach"=>$input['reach'],
                                 "gain"=>$input['gain'],
                                 "systemUid"=>$systemUid,
                                 "uidUser"=>($input['uidUser']??$uidCreator),//here is card number
                                // "uidCreator"=>$uidCreator,
                                 "uidCreator"=>Auth::user()->uid,
                                 "subscriber"=>$subscriber,
                                 "temporalData"=>json_encode($json_array),
                                 "commentData"=>$input['commentData']??'none',
                                 "created_at"=>$this->today,
                                 "updated_at"=>$this->today
                             ] );


                                 $check=DB::update("update admnin_records set balance=balance+:balance,addBalance=addBalance-:addBalanceM where uid=:uid and systemUid=:systemUid limit 1",array(
                                    // "uid"=>$uidCreator,
                                     "uid"=>Auth::user()->uid,
                                     "systemUid"=>$input['systemUid'],
                                     "balance"=>$inputData,
                                     "addBalanceM"=>$inputData
                                     //"dettes"=>($input['all_total']-$input['inputData'])
                                 ));
                                 return [
                                    "status"=>true,
                                    "result"=>$results,
                                    "token"=>$uid,
                                    "token2"=>mt_rand(10000, 99999)."-".mt_rand(10000, 99999)."-".mt_rand(10000, 99999)."-".mt_rand(10000, 99999)


                                ];



                         }
                         else{
                            return [
                                "status"=>false,
                                "result"=>"something Wrong",


                            ];

                         }


                             return [
                                 "status"=>true,
                                 "result"=>$results,


                             ];


                         }
                         else{
                             return [
                                 "status"=>false,
                                 "Your Balance"=>$AdminBalance[0]->addBalance,
                                 "message"=>"insufficient Balance on Your Account"

                             ];
         ///
                         }

                     }
                     else{
                          //there is no more electricity available in our platform
          return [
             "status"=>false,
             "result"=>"!",
             "message"=>"please Contact System Admin"

         ];

                     }


        });
        return response($check,200);
            //code...
        } catch (\Exception $e) {
            DB::rollback();
            return response()->json([
                'error' => 'An error occurred',
                'errorPrint' => $e->getMessage(),
                'errorCode' => $e->getLine(),
            ], 500);
        }

        //
    }
    public function InsertUser($input){
        $checkUser=DB::select("select uid from users where uid=:uid limit 1",[
            "uid"=>$input['uidUser']
        ]);
        if($checkUser){
            return true;
        }
        else{
            $password=date(time());
            $check=DB::table("users")
            ->insert([
                "uid"=>$input['uidUser'],
                "uidCreator"=>Auth::user()->uid,
                'password'=>bcrypt($password),

            ]);
            if($check){
                return true;
            }
            else{
                return false;
            }

        }
    }

    public function checkKwt($input){
        $productPrice=DB::select("select price,qty,qty_sold from products where subscriber=:subscriber and productCode=:productCode limit 1",array(
            "productCode"=>$productCode,

            "subscriber"=>Auth::user()->subscriber
           ));//validate product price

            $AdminBalance=DB::select("select addBalance from admnin_records where uid=:uid and status=:status limit 1",[
                "uid"=>Auth::user()->uid,
                "status"=>'Sales'
            ]);

            $req_qty=(1/$productPrice[0]->price)*$inputData;
                $req_qty=floor($req_qty * 100) / 100;
                //echo $req_qty;
            if($req_qty<=($productPrice[0]->qty-$productPrice[0]->qty_sold))
            {


                //$req_qty=10.2;
                if($inputData<=$AdminBalance[0]->addBalance)//check admin Balance
                {
                    return response([
                        "status"=>true,
                        "message"=>"You will get".$req_qty,

                    ],200);
                }
                else{
                    return [
                        "status"=>false,
                        "Your Balance"=>$AdminBalance[0]->addBalance,
                        "message"=>"insufficient Balance on Your Account"

                    ];
///
                }
            }
            else{
                 //there is no more electricity available in our platform
 return [
    "status"=>false,
    "result"=>"!",
    "message"=>"please something is wrong Contact System Admin"

];

            }
    }
    public function AdminAccountBalance(){//my Balance

    }
    public function UserAccountBalance(){//Reseller Account Balance

    }
    public function getUserSales(){

    }
    public function getResellerProfit(){

    }


}
