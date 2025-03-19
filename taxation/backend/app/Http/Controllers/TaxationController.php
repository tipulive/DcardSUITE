<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use Illuminate\Support\Facades\Validator;
use App\Http\Controllers\ParticipateController;
use DB;
use Auth;
use Illuminate\Support\Str;

class TaxationController extends Controller
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

    public function Category($input){

        try {
            //code...
            $isActionInput=strtolower($input["isActionInput"]);
            if($isActionInput=='create_category')
            {
                return $this->CreateCategory($input);
            }
            else if($isActionInput=='edit_category')
            {

            }
            else{

            }
        } catch (\Exception $e) {
            DB::rollback();
            return response()->json([
                'error' => 'An error occurred',
                'errorPrint' => $e->getMessage(),
                'errorCode' => $e->getLine(),
            ], 500);
        }

    }
public function LoadCategory($input){
    try {
        //code...
        $isActionInput=strtolower($input["isActionInput"]);
        if($isActionInput=='load_category')
        {
            return $this->load_category($input);
        }
        else if($isActionInput=='search_category')
        {

        }
        else{

        }
    } catch (\Exception $e) {
        DB::rollback();
        return response()->json([
            'error' => 'An error occurred',
            'errorPrint' => $e->getMessage(),
            'errorCode' => $e->getLine(),
        ], 500);
    }
}
public function SumReportTotal($input)
{
    $check=DB::select("SELECT
    SUM(CASE WHEN (DATE(created_at) =CURDATE()) THEN total ELSE 0 END) AS today_sales,
    SUM(CASE WHEN YEARWEEK(created_at,1) = YEARWEEK(CURDATE(), 1) THEN total ELSE 0 END) AS week_sales,
    SUM(CASE WHEN (YEAR(created_at) = YEAR(CURDATE()) AND MONTH(created_at) = MONTH(CURDATE())) THEN total ELSE 0 END) AS month_sales,
    SUM(CASE WHEN (YEAR(created_at) = YEAR(CURDATE())) THEN total ELSE 0 END) AS year_sales,
    SUM(CASE WHEN  (YEAR(created_at) = YEAR(CURDATE())- 1)  THEN total ELSE 0 END) AS last_year_sales,
    SUM(total) AS all_sales
  FROM orders where uidCreator=:uidCreator",[
    "uidCreator"=>auth::user()->uid
  ]);
    if($check) {
        return response([
            "status" => true,

            "result" => $check
        ]);
    } else {
        return response([
            "status" => false,

            "result" => $check
        ]);
    }
}
public function load_category($input){

    $check=DB::select("select *from categories");
    if($check) {
        return response([
            "status" => true,

            "result" => $check
        ]);
    } else {
        return response([
            "status" => false,

            "result" => $check
        ]);
    }
}
    public function CreateCategory($input){
        $name= strtolower($input['name']);

        $checkExist=DB::select("select name from categories where name=:name limit 1",[
            "name"=>$name
        ]);

        if(!$checkExist)
        {
            $uid=preg_replace('/[^A-Za-z0-9-]/','',$input['name']);
            $uid=$uid.""."_".date(time());
            $check=DB::table("categories")
            ->insert([
              "uid"=>$uid,
              "name"=>$input["name"],
              "subscriber"=>Auth::user()->subscriber,
              "uidCreator"=>Auth::user()->uid,
              "percentage"=>$input["percentage"]??0,//percentage all to this category
              "commentData"=>$input["commentData"]??'none',
              "created_at"=>$this->today
            ]);
            if($check) {
                return response([
                    "status" => true,

                    "result" => $check
                ]);
            } else {
                return response([
                    "status" => false,

                    "result" => $check
                ]);
            }
        }
        else {
            return response([
                "status" => false,

                "result" =>"$name Category exist"
            ]);
        }

    }

    public function Measurement($input){


        try {
            //code...
            $isActionInput=strtolower($input["isActionInput"]);
            if($isActionInput=='create_measure')
            {
                return $this->CreateMeasure($input);
            }
            else if($isActionInput=='edit_measure')
            {

            }
            else{

            }
        } catch (\Exception $e) {
            DB::rollback();
            return response()->json([
                'error' => 'An error occurred',
                'errorPrint' => $e->getMessage(),
                'errorCode' => $e->getLine(),
            ], 500);
        }
    }

    public function CreateMeasure($input){


        $name= strtolower($input['name']);
        $checkExist=DB::select("select name from measurements where name=:name limit 1",[
            "name"=>$name
        ]);
        if(!$checkExist)
        {
            $uid=preg_replace('/[^A-Za-z0-9-]/','',$name);
            $uid=$uid.""."_".date(time());
            $check=DB::table("measurements")
            ->insert([
              "uid"=>$uid,
              "name"=>$name,
              "subscriber"=>Auth::user()->subscriber,
              "uidCreator"=>Auth::user()->uid,
              "commentData"=>$input["commentData"]??'none',
              "created_at"=>$this->today
            ]);
            if($check) {
                return response([
                    "status" => true,

                    "result" => $check
                ]);
            } else {
                return response([
                    "status" => false,

                    "result" => $check
                ]);
            }
        }else {
            return response([
                "status" => false,

                "result" =>"$name measure exist"
            ]);
        }

    }
    public function Taxproduct($input){//products

        $productCode= strtolower(($input['productCode']??'none'));
        $productName= strtolower(($input['productName']??'none'));

        $checkExist=DB::select("select productCode from products where productCode=:productCode and subscriber=:subscriber limit 1",[
            "productCode"=>$productCode,
            "subscriber"=>auth::user()->subscriber
        ]);
        if(!$checkExist)
        {
            $uid=preg_replace('/[^A-Za-z0-9-]/','',$productCode);
            $uid=$uid.""."_".date(time());
            $check=DB::table("products")
            ->insert([
               "uid"=>$uid,
              "productCode"=>$productCode,
              "productName"=>$productName,
              "cat"=>$input["cat"]??'none',//category Uid
              "catName"=>$input["catName"]??'none',//country of origin

              "qty"=>$input["qty"]??0,//means for example 10 container of sugar cost 8000$
              "price"=>$input["price"],
              "measurement"=>$input["measurement"]??'none',//measure :container,diameter,little,etc..,meter
              "subscriber"=>Auth::user()->subscriber,
              //"uidCreator"=>Auth::user()->uid,
              "description"=>$input["commentData"]??'none',
              "created_at"=>$this->today
            ]);

            if ($check) {
                return response([
                    "status" => true,

                    "result" => $check
                ]);
            } else {
                return response([
                    "status" => false,

                    "result" => $check
                ]);
            }
        }else {
            return response([
                "status" => false,

                "result" =>"product Code exist"
            ]);
        }


    }

    public function placeDeclareOrder($input){
        return $this->placeOrder($input);
    }

    public function placeOrder($input){


        $req_qty=$input['req_qty'];
        if($req_qty!=0)
        {
            $productCode=$input['productCode'];
            $input['statusForm']??'none';
            $currentQtyOfOrder=$input['currentQtyOfOrder']??0;
           // $req_qtyProduct=$input['req_qtyFromorderEdit']??$input['req_qty'];
              $SignChange=($input['statusForm']=='editOrder')?"-$currentQtyOfOrder+":'+';
            //list($QueryFactory,$myArray) = ($input['statusForm']=='editOrder') ? [$QueryFactoryDelete,$sqlDelete,$myArrayDelete] : [$QueryFactoryUpdate,$sqlUpdate,$myArrayUpdate];
            $orderId=$input['orderIdFromEdit']??'none';
            $uid =($orderId=='none')?"UID"."_".Str::random(2).""."_".date(time()):$orderId;
           // echo $uid;
           $checkAvoid=DB::select("select uid from orders where uid=:uid limit 1",[
            "uid"=>$uid
            ]);
    if($checkAvoid)
    {
        return response([
            "status"=>false,
            "message"=>'there is a problem of duplicate ID',
             ],200);
    }
    else{
        $checkDup=DB::select("select  uid from orderhistories where uid=:uid and paidStatus=:paidStatus limit 1",[
            "uid"=>$uid,
            "paidStatus"=>'checked'
            ]);
        if($checkDup){
                 //Some Duplicate please
                 echo"not exist";
        }
        else{
        //Working
        return $this->testorderPlace($input,$uid);

        }
    }
    }
    else{
            return response([
                "status"=>false,
                "message"=>'qty is not enough',
                 ],200);
    }


    }


    public function testorderPlace($input,$uid){
        $req_qty=$input['req_qty'];
        $productCode=$input['productCode'];
        $product=DB::select("select price,measurement,qty from products where subscriber=:subscriber and productCode=:productCode limit 1",array(
         "productCode"=>$productCode,
         "subscriber"=>Auth::user()->subscriber
        ));
        //$orderId=$input['orderIdFromEdit']??'none';
        //$uid =($orderId=='none')?"UID"."_".Str::random(2).""."_".date(time()):$orderId;



        if($product){
            $checkInsert=DB::table("orderhistories")
            ->insert([
                'uid' =>$uid,
                'userid'=>$input['uidClient'],
                'safariId'=>"safari",
                "order_creator"=>Auth::user()->uid,
                "subscriber"=>Auth::user()->subscriber,
                'productCode'=>$productCode,
                'price'=>$product[0]->price,
                'measurement'=>$product[0]->measurement,
                'qty'=>$input["req_qty"],
                'qty_count'=>$input["req_qty"],
                'total'=>round((($product[0]->price/$product[0]->qty)*$input["req_qty"]), 2),//for searching initQt initqty=(priceofInitQty *req_qty)/totalQty
                'OrderData'=>json_encode([]),
                'comment_count'=>json_encode([]),
                "created_at"=>$this->today,
                "updated_at"=>$this->today
            ]);
            /*DB::update("update orders set userid=:userid where uid='1' limit 1",array(
                'userid' =>'kati6'
                ));*/


    if($checkInsert)
    {

        return response([

            "status"=>true,
            //"result"=>$results,

            "OrderId"=>$uid,
            //"data"=>$data



            ],200);
    }
    else{
        return response([

            "status"=>false,



            ],200);
    }

        }
        else{
            return response([

                "status"=>false,
                "message"=>"product is not available"



                ],200);
        }






    }
    public function SubmitDeclareOrder($input){

        $check_InputData=$input['all_total']-$input['inputData'];//all_total :niyo total ya orders,custom_price or inputData=niyo client yishyuye cash

        if($input['all_total']>$input['inputData'])
        {
            return $this->admin_record($input);
        }
        else{
           return $this->admin_record($input);


           //return (new ParticipateController)->participate($input);



        }

//$check_InputData<=0?(new ParticipateController)->participate($input):$this->notparticipate();//means client azaba yishyuye yose nta deni afite

    }
    public function admin_record($input){


        try{


            $checks=DB::transaction(function () use ($input) {
                $uidCreator=Auth::user()->uid; //is the one who will pay money to client when he will withdraw
            $subscriber=Auth::user()->subscriber;
            $systemUid=$input['systemUid'];
            $mamaUid="MSolange_1709926940";
            $UserId=($input["uidUser"]===$mamaUid)?$mamaUid:Auth::user()->uid;

                  $checkAvoid=DB::select("select uid from orders where uid=:uid limit 1",[
                   "uid"=>$input["OrderId"]
                   ]);
 if($checkAvoid)
 {
      return $checkAvoid;
 }
 else{
      $checkSum=DB::select("select sum(total) as total from orderhistories where uid=:uid limit 2000",[
                "uid"=>$input["OrderId"]
            ]);


    //
           if($checkSum){
            $input['all_total']=$checkSum[0]->total;

            DB::update("update orderhistories set

            all_total=:all_total,custom_price=:custom_price,
            paidStatus ='checked',orderDebt=:orderDebt,order_creator=:order_creator
            where uid=:uid and userid=:userid limit 100",array(
                "uid"=>$input["OrderId"],
                "userid"=>$input["uidUser"],
                "orderDebt"=>$input['all_total']-$input['all_total'],
                "all_total"=>$input['all_total'],
                "custom_price"=>$input['all_total'],
                "order_creator"=>$UserId



            ));

            $paidStatus = ($input['all_total'] == $input['all_total']) ? 'paid' : (($input['inputData'] > $input['all_total']) ? 'paidReturn' : 'dettes');

            $json_array =  [
                [
                "uid"=>$input["OrderId"],//orderId
                "total"=>$input['all_total'],
                "paid"=>$input['all_total'],
                "debt"=>$input['all_total']-$input['all_total'],
                "promotionUid"=>$input['uid'],
                "reach"=>$input['reach'],
                "gain"=>$input['gain'],
                "paidStatus"=>$paidStatus,
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
                "uid"=>$input["OrderId"],//orderId
                "total"=>$input['all_total'],
                "paid"=>$input['all_total'],
                "debt"=>$input['all_total']-$input['all_total'],
                "paidStatus"=>$paidStatus,
                "promotionUid"=>$input['uid'],
                "reach"=>$input['reach'],
                "gain"=>$input['gain'],
                "systemUid"=>$systemUid,
                "uidUser"=>($input['uidUser']??$uidCreator),
               // "uidCreator"=>$uidCreator,
                "uidCreator"=>$UserId,
                "subscriber"=>$subscriber,
                "temporalData"=>json_encode($json_array),
                "commentData"=>$input['commentData']??'none',
                "created_at"=>$this->today,
                "updated_at"=>$this->today
            ] );


                $check=DB::update("update admnin_records set balance=balance+:balance,dettes=dettes+:dettes where uid=:uid and systemUid=:systemUid limit 1",array(
                   // "uid"=>$uidCreator,
                    "uid"=>$UserId,
                    "systemUid"=>$input['systemUid'],
                    "balance"=>$input['all_total'],
                    "dettes"=>($input['all_total']-$input['all_total'])
                ));
                if($check)
                {
                    return $check;
                }
                else{
                    $dataInsert=DB::table("admnin_records")
                    ->insert([
                       // "uid"=>$uidCreator,
                       "uid"=>$UserId,
                        "subscriber"=>$subscriber,
                        "systemUid"=>$input['systemUid'],
                        "status"=>'Sales',
                        "balance"=>$input['all_total'],
                        "dettes"=>($input['all_total']-$input['all_total'])

                    ]);
                    return $dataInsert;
                }
           }
 }


 });


            return response([

                "status"=>true,
                "result"=>$checks,





                ],200);


            } catch (\Exception $e) {
                DB::rollback();
               // throw $e;
                return response()->json(["status"=>false,'error' => 'An error occurred',
            'errorPrint'=>$e->getMessage(),"errorCode"=>$e->getLine()], 500); // Return an error JSON response
            }

    }
}


