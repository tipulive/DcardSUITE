<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\ParticipateController;
use DB;
use Auth;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Cache;

class StockController extends Controller
{
    //
    public function __construct()
    {
        date_default_timezone_set(env('TIME_ZONE'));
        $this->today = date('Y-m-d H:i:s', time());
        $this->Appstate=env('APP_LIVE')?env('APP_PRO'):env('APP_DEV');
        $this->AppName=env('APP_NAME');

        $this->otp='1 hours';
      // $this->otp='20 seconds';//test purpose
        $this->email_confirm='24 hours';
        $this->Admin_Auth_error="You Are not authenticate please Request Permission to Admin";
        $this->Admin_Auth_result_error="0";//Admin auth result zero
        $this->platform1=env('PLATFORM3');
    }

    public function GetSafaris($input)
    {

        $check=DB::select("select *from safariStocks  where subscriber=:subscriber ORDER BY id DESC
        LIMIT 100",array(
            "subscriber"=>Auth::user()->subscriber
        ));
        if($check)
        {
            return response([
                // "allinput"=>$input,
                // "data2"=>$input["item"],
                "status"=>true,

                "result"=>$check//safari UId

             ]);
        }
        else{
            return response([
                // "allinput"=>$input,
                // "data2"=>$input["item"],
                "status"=>false,


             ]);
        }
    }
    public function create($input)
    {
        $uid=$input["name"].""."_".Str::random(5).""."_".date(time());
        $check=DB::table("safariStocks")
         ->insert([
             "uid"=>$uid,
             "name"=>$input["name"],
             "comment"=>$input["comment"]??'none',
             "uidCreator"=>Auth::user()->uid,
             "subscriber"=>Auth::user()->subscriber,

             "created_at"=>$this->today
         ]);

         if($check)
         {
            return response([
                // "allinput"=>$input,
                // "data2"=>$input["item"],
                "status"=>true,
                "safariuid"=>$uid,
                "name"=>$input["name"],
                "result"=>$uid//safari UId

             ]);

         }
         else{
            return response([
                // "allinput"=>$input,
                // "data2"=>$input["item"],
                "status"=>false,
                "result"=>$check

             ]);
         }
    }
    public function EditSafari($input)
    {
        //"comment"=>$input["name"]??'none',

        $uid=$input['uid'];
        $check=DB::update("update safariStocks set name=:name,comment=:comment,updated_at=:updated_at where uid=:uid and subscriber=:subscriber limit 1",array(
            "uid"=>$input["uid"],
            "subscriber"=>Auth::user()->subscriber,
            "name"=>$input["name"],
            "comment"=>$input["comment"],
            "updated_at"=>$this->today,
            //$checkupdate
        ));
        if($check)
        {
            return response([
                "status"=>true,
                "result"=>$check,

            ],200);

        }
        else{
         return response([
             "status"=>false,
             "result"=>$check,

         ],201);
        }

    }
    public function Delete($input){//note this must hide to avoid delete all my tables
        $check=DB::delete("delete from safariStocks where uid=:uid limit 1",array(

            "uid"=>$input["uid"]
        ));
        if($check)
        {
            return response([
                "status"=>true,
                "result"=>$check1,

            ],200);

        }
        else{
         return response([
             "status"=>false,
             "result"=>$check,

         ],201);
        }
    }

    public function SearchProduct($input)
    {
    $productName=strtolower($input["productName"]??'none');

    $productCode=strtolower($input["productCode"]??'none');
    list($queryData,$itemName) = ($productCode!='none') ? ['productCode','%' . $productCode. '%'] : ['productName','%' . $productName. '%'];


        $check=DB::select("select *from products where subscriber=:subscriber and $queryData LIKE :itemName LIMIT 20",array(
            "itemName"=>$itemName,
            "subscriber"=>Auth::user()->subscriber

           ));

        if($check)
        {
           return response([
               // "allinput"=>$input,
               // "data2"=>$input["item"],
               "status"=>true,

               "result"=>$check

            ]);

        }
        else{
           return response([
               // "allinput"=>$input,
               // "data2"=>$input["item"],
               "status"=>false,
               "result"=>$check

            ]);
        }
    }
    public function AddItem($input)//Add product in Product and SafariProduct too ,this require me to add transaction
    {
        //Ndakora check if product exist in products and in safariProducts mbere yo gushyiramo Products

        //$uid=Auth::user()->subscriber.""."_".Str::random(5).""."_".date(time());
        /*$checkExist=DB::select("select productName from products where productName=:productName limit 1",array(
         "productName"=>strtolower($input["productName"])
        ));*/
        $checkExist=($input['productCode']!='0')?true:false;//check if ProductCode Exist

        if($checkExist)
        {
            $checkProduct=DB::select("select productCode from safariproducts where safariId=:safariId and productCode=:productCode and subscriber=:subscriber limit 1",array(
                "safariId"=>$input["safariId"],
                "productCode"=>$input['productCode'],
                "subscriber"=>Auth::user()->subscriber

            ));
            if($checkProduct)
            {
                return response([

                    "status"=>false,
                    "result"=>"ProductExist ,please add another product or adjust"

                 ]);
            }
            else{
                $qty=$input['qty'];
                $check=DB::update("update products set qty=qty+$qty where productCode=:productCode and subscriber=:subscriber limit 1",array(
                        'productCode'=>$input['productCode'],//product id
                        'subscriber'=>Auth::user()->subscriber


                  // "updated_at"=>$this->today,
                    ));

                if($check)
                {
                    $productCode=$input['productCode'];
                    return $this->createInStockProduct($input,$productCode);
                }
                else{
                    return response([

                        "status"=>false,
                        "result"=>$check

                     ]);
                }

            }

        }
        else{
            $uid=preg_replace('/[^A-Za-z0-9-]/','',strtolower($input["productName"]));//generated on production
            //echo $this->today;
            $productCode=$uid.""."_".date(time());
            $check=DB::table("Products")
            ->insert([
        "cat"=>$input['cat']?:'none',//comeFrom
        "catName"=>$input['catName']?:'none',//comeFrom
        'productCode'=>$productCode,//product id
        'productName'=>strtolower($input["productName"]),//product id

        "subscriber"=>Auth::user()->subscriber,
 //owner of the products
        "price"=>$input['price'],//who give item

        "qty"=>$input['qty'],
        "pcs"=>$input['pcs']?:'none',
       "total"=>$input['qty']*$input['price'],

  // "img_url"=>$mult_imgurl->att_url,
       "img_url"=>"none"?:'none',

      "tags"=>(strtolower($input['tags']))?:NULL,
      'active'=>$input['active']?:'none',
      "description"=>$input['description']?:'none',
        "created_at"=>$this->today,
            ]);
            if($check)
            {

                return $this->createInStockProduct($input,$productCode);
            }
            else{
                return response([

                    "status"=>false,
                    "result"=>$check

                 ]);
            }
        }



    }
    public function createInStockProduct($input,$productCode)//everything related in That Stock
    {

          try {
            //code...

            $check=DB::table("safariproducts")
            ->insert([
                "safariId"=>$input["safariId"],
                "productCode"=>$productCode,//(it may be productCode or uid of spending)
                "price"=>$input["fact_price"],
                "qty"=>$input["qty"],
                "totQty"=>$input["qty"],
                "TotBuyAmount"=>$input["qty"]*$input["fact_price"],
                "status"=>$input["status"]??"none",
                "CommentStatus"=>$input["CommentStatus"]??"none",

                "uidCreator"=>Auth::user()->uid,
                "subscriber"=>Auth::user()->subscriber,
                "created_at"=>$this->today
            ]);
            if($check)
            {
                return response([
                    // "allinput"=>$input,
                    // "data2"=>$input["item"],
                    "status"=>true,
                    "safariuid"=>$input["safariId"],
                    "safariName"=>$input["name"],
                    "result"=>$input["uid"]

                 ]);
            }
            else{
                return response([

                    "status"=>false,
                    "result"=>$check

                 ]);
            }
        }  catch (\Exception $e) {
            DB::rollback();
           // throw $e;
            return response()->json(['error' => 'An error occurred',
        'errorPrint'=>$e->getMessage(),"errorCode"=>$e->getLine()], 500); // Return an error JSON response
        }



    }

    public function EditProductPrice($input){ //Edit only ProductPrice tempTable is missing
        $checkDB=DB::update("update products set price=:price,updated_at=:updated_at where productCode=:productCode and subscriber=:subscriber limit 1",array(
            'productCode'=>$input['productCode'],//product id
            'price'=>$input['price'],
            "subscriber"=>Auth::user()->subscriber,
            'updated_at'=>$this->today
            ));
    }

    public function EditProducts($input){ //Edit all Products ProductPrice tempTable is missing
        $checkDB=DB::update("update products set price=:price,productName=:productName,cat=:cat,catName=:catName,tags=:tags,active=:active,pcs=:pcs,updated_at=:updated_at where productCode=:productCode and subscriber=:subscriber limit 1",array(
            'productCode'=>$input['productCode'],//product id
            'price'=>$input['price'],
            'productName'=>$input['productName'],
            'cat'=>$input['cat'],
            'catName'=>$input['catName'],
            'tags'=>$input['tags'],
            'active'=>$input['active'],
            "pcs"=>$input["pcs"],
            "subscriber"=>Auth::user()->subscriber,
            'updated_at'=>$this->today
            ));
    }
    public function EditStockQty($input) //Edit Stock Qty tempTable is missing
    {



        try {
            $check=DB::transaction(function () use ($input) {//

                $checkDB=DB::update("update products set qty=qty+:qty,updated_at=:updated_at where productCode=:productCode and subscriber=:subscriber limit 1",array(
                    'productCode'=>$input['productCode'],//product id
                    'qty'=>$qty,
                    "subscriber"=>Auth::user()->subscriber,
                    'updated_at'=>$this->today
                    ));

                    $check=DB::update("update safariProducts set qty=qty+:qty,updated_at=:updated_at where subscriber=:subscriber and safariId=:safariId and productCode=:productCode limit 1",array(
                        "productCode"=>$input['productCode'],
                        "safariId"=>$input["safariId"],
                        "subscriber"=>Auth::user()->subscriber,
                         "price"=>$input["price"],


                         "updated_at"=>$this->today
                    ));
            });


        } catch (\Exception $e) {
            DB::rollback();
            // throw $e;
             return response()->json(['error' => 'An error occurred',
         'errorPrint'=>$e->getMessage(),"errorCode"=>$e->getLine()], 500); // Return an error JSON response
        }



    }

    public function EditStockFactPrice($input) //Edit Stock Factories price tempTable is missing
    {



        $check=DB::update("update safariProducts set fact_price=:fact_price,updated_at=:updated_at where subscriber=:subscriber and safariId=:safariId and productCode=:productCode  limit 1",array(
            "productCode"=>$input["productCode"],
            "safariId"=>$input["safariId"],
            "subscriber"=>Auth::user()->subscriber,
             "price"=>$input["price"],


             "updated_at"=>$this->today
        ));
        if($check)
        {
            return response([
                "status"=>true,
                "safariuid"=>$input["safariId"],
               // "name"=>$input["SafariName"]

            ],200);

        }
        else{
         return response([
             "status"=>false,
             "result"=>$check,

         ],201);
        }
    }


    public function DeleteItem($input)
    {
        $safariuid=$input["safariuid"];
        $check=DB::delete("delete from safariProducts where safariuid=:safariuid limit 1",array(

            "safariuid"=>$safariuid
        ));
        if($check)
        {
            return response([
                "status"=>true,
                "result"=>$check1,

            ],200);

        }
        else{
         return response([
             "status"=>false,
             "result"=>$check,

         ],201);
        }
    }
    public function EditProductsd($input) //Edit Item in Product and in StockProducts
    {

        $check=DB::update("update safariProducts set uid=:uid,price=:price,SoldInterest=:SoldInterest,qty=:qty,pcs=:pcs,updated_at=:updated_at,comment=:comment where safariuid=:safariuid and id=:id limit 1",array(
            "safariuid"=>$input["safariuid"],
             "id"=>$input["id"],
             "uid"=>$input["uid"],
             "price"=>$input["price"],
             "SoldInterest"=>$input["SoldInterest"],

             "qty"=>$input["qty"],
             "pcs"=>$input["pcs"],

             "comment"=>$input["comment"],

             "updated_at"=>$this->today
        ));
        if($check)
        {
            return response([
                "status"=>true,
                "safariuid"=>$input["safariuid"],
                "name"=>$input["name"]

            ],200);

        }
        else{
         return response([
             "status"=>false,
             "result"=>$check,

         ],201);
        }
    }

    //my code of buying and calculator
    public function displayCalculate($input){



        $stockInterest=$input['safariId']."_"."int";//interest
        $stockDisplay=$input['safariId']."_"."dis";//display Stock

       /* Cache::put($stockInterest,'',now()->addMinutes(0));
        Cache::put($stockDisplay,'',now()->addMinutes(0));*/
        if($this->interest_check($input))
        {


         return response([
                "status"=>true,
                "name"=>$input['name'],
                "safariuid"=>$input['safariId'],
                "result"=>Cache::get($stockDisplay),

                "interest"=>Cache::get($stockInterest),
           ],200);

        }
        else{


            return response([
                "test"=>"go",
                "status"=>true,
                "name"=>$input['name'],
                "safariuid"=>$input['safariId'],
                "result"=>Cache::get($stockDisplay),
                "interest"=>Cache::get($stockInterest),
             ],200);
        }
        // End time

    }
      public function interest_check($input){
        $safariId=$input['safariId'];
        $stockInterest=$input['safariId']."_"."int";//interest
        $stockDisplay=$input['safariId']."_"."dis";//display Stock
        if(Cache::get($stockInterest))
        {

            return true;
        }
        else{
            $interest=DB::select("SELECT
            SUM(TotSoldAmount) AS Soldout,
            SUM(TotBuyAmount) AS buyout,
            SUM(totQty) AS TotQty,
            SUM(SoldOut) AS QtySoldOut,
            SUM(TotSoldAmount - TotBuyAmount) AS interest
        FROM safariProducts where safariId=:safariId limit 1000",array(
                "safariId"=>$safariId
             ));
             $displayData=DB::select("select * from safariProducts where safariId=:safariId limit 1000",array(
                 "safariId"=>$safariId
              ));



             Cache::put($stockInterest,$interest,now()->addMinutes(60));
             Cache::put($stockDisplay,$displayData,now()->addMinutes(60));
        }
      }
    public function calculateAll($input){


        $safariId=$input['safariId'];
        $stockInterest=$input['safariId']."_"."int";
        $stockTempInterest=$input['safariId']."_"."tempInt";//Tempinterest
        $spend=(strpos(strtolower($input['status']),'spend') !== false)?true:false;
        $TotQtyPrice=$input['qty']*$input['price'];
        $TotTempBuy=(strpos(strtolower($input['status']),'spend') !== false)?$TotQtyPrice:"0";
        $TotTempSold=(strpos(strtolower($input['status']),'gain') !== false)?$TotQtyPrice:"0";
        /*$TotTempBuy=($input['status']==='spend')?$TotQtyPrice:"0";
        $TotTempSold=($input['status']==='gain')?$TotQtyPrice:"0";*/

        $interest=($this->interest_check($input))?Cache::get($stockInterest)[0]->interest:'0';

        if(Cache::get($stockTempInterest)) //means there is no update in Stock in Safari or no expiration in Safari
        {
            $data1=Cache::get($stockTempInterest);


            $data1["TotTempBuy"]=(Cache::get($stockTempInterest)["TotTempBuy"])+$TotTempBuy;
            $data1["TotTempSold"]=(Cache::get($stockTempInterest)["TotTempSold"])+$TotTempSold;
            $data1["TempInterest"]=((Cache::get($stockTempInterest)["TotTempSold"])+$TotTempSold)-((Cache::get($stockTempInterest)["TotTempBuy"])+$TotTempBuy);
            $data1["Interest"]= $interest;//really interest
            $data1["SumInterest"]=$interest +((Cache::get($stockTempInterest)["TotTempSold"])+$TotTempSold)-((Cache::get($stockTempInterest)["TotTempBuy"])+$TotTempBuy);

            $data1["results"][]=[
                'safariId' =>$input["safariId"],
                 'productCode' =>$input["productCode"],
                 'price' =>$input["price"],
                 'qty' =>$input["qty"],
                 'status' =>$input["status"],
                'TotBuyAmount' =>$TotTempBuy,
                 'TotSoldAmount' =>$TotTempSold,
                 'CommentStatus'=>$input["CommentStatus"]??'none'

                // Add more rows here if needed
            ];


            //Cache::put("Sum",$data1,now()->addMinutes(60));

            Cache::put($stockTempInterest,$data1,now()->addMinutes(60));
            return response([



                "data1"=>Cache::get($stockTempInterest),
                "data2"=>Cache::get($stockInterest)[0]->interest




                ],200);
        }
        else{


            $data1["TotTempBuy"]=$TotTempBuy;
            $data1["TotTempSold"]=$TotTempSold;
            $data1["TempInterest"]=$TotTempSold-$TotTempBuy;
            $data1["Interest"]=$interest;//really interest
            $data1["SumInterest"]=$interest +($TotTempSold-$TotTempBuy);//Sum interest (really Interest- TempInterest)
            $data1["results"][]=[
                'safariId' =>$input["safariId"],
                 'productCode' =>$input["productCode"],
                 'price' =>$input["price"],
                 'qty' =>$input["qty"],
                 'status' =>$input["status"],
                 'TotBuyAmount' =>$TotTempBuy,
                 'TotSoldAmount' =>$TotTempSold,
                 'CommentStatus'=>$input["CommentStatus"]??'none'

                // Add more rows here if needed
            ];
            Cache::put($stockTempInterest,$data1,now()->addMinutes(60));

            return response([



                "data1"=>Cache::get($stockTempInterest)



                ],200);
        }

    }
    public function GetDispTempCalculator($input){
        $safariId=$input['safariId'];
        $stockInterest=$input['safariId']."_"."int";
        $stockTempInterest=$input['safariId']."_"."tempInt";//Tempinterest
        return response([



            "data1"=>Cache::get($stockTempInterest)



            ],200);
    }
    public function ResetTempCalculator($input){
        $safariId=$input['safariId'];
        $stockInterest=$input['safariId']."_"."int";
        $stockTempInterest=$input['safariId']."_"."tempInt";//Tempinterest
        Cache::forget($stockTempInterest);
        return response([



            "data1"=>Cache::get($stockTempInterest)



            ],200);
    }
    public function SaveCalculateTemp($input){//temp Calculator
        $safariId=$input['safariId'];
        $stockInterest=$input['safariId']."_"."int";
        $stockTempInterest=$input['safariId']."_"."tempInt";//Tempinterest
        $json_array=[

           "data1"=>Cache::get($stockTempInterest),
           "data2"=>Cache::get($stockInterest)[0]->interest,
        ];
if((Cache::get($stockTempInterest))!=null)
{
    $uid=preg_replace('/[^A-Za-z0-9-]/','',$input['name']);
    $uid=$uid.""."_".date(time());
    $check=DB::table("temp_tables")
    ->insert([
        "uid"=>$uid,
        "name"=>$input['name'],
        "tempData"=>json_encode($json_array),
        "subscriber"=>Auth::user()->subscriber,
        "uidCreator"=>Auth::user()->uid,
        "actionTable"=>"SaveCalculatorInterest",
        "systemUid"=>$input['systemUid'],
        "commentData"=>$input["commentData"]??'none',
        "created_at"=>$this->today
    ]);
}
else{
    return response([

        "status"=>false,
        "message"=>"No temp Data to insert"



     ],200);
}


    }
    public function UpdatecalculateTemp($input){//temp Calculator
        $safariId=$input['safariId'];
        $stockInterest=$input['safariId']."_"."int";
        $stockTempInterest=$input['safariId']."_"."tempInt";//Tempinterest
        $json_array=[

            "data1"=>Cache::get($stockTempInterest),
            "data2"=>Cache::get($stockInterest)[0]->interest
         ];

        $check=DB::update("update temp_tables set tempData=:tempData where uid=:uid and uidCreator=:uidCreator limit 1",array(
           "tempData"=>json_encode($json_array),
           "uid"=>$input["uid"],
           "uidCreator"=>Auth::user()->uid

       ));
    }
    public function DeleteCalculateTemp($input){
        $check = DB::delete("DELETE FROM temp_tables WHERE uid = :uid AND subscriber = :subscriber LIMIT 1", [
            "uid" => $input['uid'],
            "subscriber" => Auth::user()->subscriber
        ]);

        if ($check) {
            return response([
                "status" => true,
            ], 200);
        } else {
            return response([
                "status" => false,
            ], 200);
        }


    }
    public function GetAllcalculateTemp($input){//later i will add pagination
        $check=DB::select("select name,uid From temp_tables where uidCreator=:uidCreator and subscriber=:subscriber limit 100",array(
            "uidCreator"=>Auth::user()->uid,
            "subscriber"=>Auth::user()->subscriber
        ));
        if($check){
            return response([



                //"data1"=>$check
                "data1"=>$check



             ],200);
        }
        else{

        }

    }


    public function UseThisCalculateTemp($input){//this will continue to use
        $safariId=$input['safariId'];
        $stockInterest=$input['safariId']."_"."int";
        $stockTempInterest=$input['safariId']."_"."tempInt";
        $check=DB::select("select name,tempData From temp_tables where uid=:uid and uidCreator=:uidCreator limit 1",array(
            "uid"=>$input['uid'],
            "uidCreator"=>Auth::user()->uid,

        ));
        $interestData=($this->interest_check($input))?Cache::get($stockInterest)[0]->interest:'0';
              $data=json_decode($check[0]->tempData, true);
              $interest=$data["data1"]["Interest"]= $interestData;
              $data2=$data["data2"]=$interestData;
              $data["data1"]["SumInterest"]=$interest +($data["data1"]["TotTempSold"])-(($data["data1"]["TotTempBuy"]));

              Cache::put($stockTempInterest,$data["data1"],now()->addMinutes(60));
        return response([


          //"data1"=>json_decode($check[0]->tempData, true),
          //"dataTest"=>(json_decode($check[0]->tempData, true))["data1"]["Interest"]
         // "data"=>$data
         "data1"=>(Cache::get($stockTempInterest)),
         "data2"=>Cache::get($stockInterest)[0]->interest


         ],200);
    }




    public function productPlaceOrder($input){//to place order

        $productCode =$input['productCode'];
       // $input=$request->all();
             return $this->placeOrder($input);

            //$myArray = [100, 20, 5, 2, 1];

    }

    public function placeOrder($input){

        $req_qty=$input['req_qty'];
        $productCode=$input['productCode'];
        $input['statusForm']??'none';
        $currentQtyOfOrder=$input['currentQtyOfOrder']??0;
       // $req_qtyProduct=$input['req_qtyFromorderEdit']??$input['req_qty'];
          $SignChange=($input['statusForm']=='editOrder')?"-$currentQtyOfOrder+":'+';
        //list($QueryFactory,$myArray) = ($input['statusForm']=='editOrder') ? [$QueryFactoryDelete,$sqlDelete,$myArrayDelete] : [$QueryFactoryUpdate,$sqlUpdate,$myArrayUpdate];
        $check=DB::update("update products set qty_sold=qty_sold  $SignChange $req_qty where subscriber=:subscriber and productCode=:productCode and qty>=qty_sold+$req_qty limit 1",array(
            "productCode"=>$productCode,
            "subscriber"=>Auth::user()->subscriber
         ));
         if($check)
         {
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
                    safariProducts
                WHERE
                    subscriber='$subscriber' and
                    productCode='$productCode' AND
                    qty != 0 AND
                    @requested_qty > 0
                ORDER BY
                    id;
            ");



                return $this->testorderPlace($results,$input);
         }
         else{

        return response([
                "status"=>false,
                "message"=>'Something Wrong check if you have enough qty of '."".$productCode,
                 ],200);
         }
    }
    public function testorderPlace($results,$input){
        $req_qty=$input['req_qty'];
        $productCode=$input['productCode'];
        $product=DB::select("select price from products where subscriber=:subscriber and productCode=:productCode limit 1",array(
         "productCode"=>$productCode,
         "subscriber"=>Auth::user()->subscriber
        ));
        $orderId=$input['orderIdFromEdit']??'none';
        $uid =($orderId=='none')?"UID"."_".Str::random(2).""."_".date(time()):$orderId;
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
                'userid'=>$input['uidclient'],
                'safariId'=>$results[$i]->safariId,
                "order_creator"=>Auth::user()->uid,
                "subscriber"=>Auth::user()->subscriber,
                'ProductCode'=>$productCode,
                'price'=>$product[0]->price,
                'qty'=>$results[$i]->qty,
                'qty_count'=>$results[$i]->qty,
                'total'=>$results[$i]->qty*$product[0]->price,
                'OrderData'=>json_encode([]),
                'comment_count'=>json_encode([]),


                // Add more rows here if needed
            ];

            $SoldOut=$results[$i]->qty;
            $totAm=$SoldOut*$product[0]->price;
            $qtyData=abs($results[$i]->remaining);
           DB::update("update safariProducts set qty=:qty,SoldOut=SoldOut+$SoldOut,TotSoldAmount=TotSoldAmount+$totAm where safariId=:safariId and productCode=:productCode and subscriber=:subscriber limit $limitData",array(
           "qty"=>$qtyData,
           "subscriber"=>Auth::user()->subscriber,
           "safariId"=>$results[$i]->safariId,
           "productCode"=>$productCode,

           ));

        }


        DB::table("orderhistories")
        ->insert($data);
        /*DB::update("update orders set userid=:userid where uid='1' limit 1",array(
            'userid' =>'kati6'
            ));*/




        return response([

            "status"=>true,
            //"result"=>$results,
            "OrderId"=>$uid,
            //"data"=>$data



            ],200);
    }
    public function productEditOrder($input){//idea behind this is first to reset cart (orderhistory),and start as new one

        $req_qty=$input['req_qty'];
        $productCode=$input['productCode'];
       // $current_qty=$input['current_qty'];
        $uid=$input['uid'];
        $subscriber=Auth::user()->subscriber;
        $results=DB::select("select *FROM
        orderhistories
    WHERE
        productCode='$productCode' AND
        uid='$uid' AND
        subscriber='$subscriber'");


        $data=[];
        $ids=[];
        $orderId="OrderId";
          $limitData=count($results);
             $totalQty=0;
        for($i=0;$i<$limitData;$i++)
        {
            $totalQty+=$results[$i]->qty;
            $id=$results[$i]->id;
            $ids[]=$results[$i]->id;
            $orderId=$results[$i]->uid;
            /*$data[] = [
                'uid' =>$uid,
                'userid'=>$input['uidclient'],
                'safariId'=>$results[$i]->SafariId,
                'ProductCode'=>$productCode,
                'price'=>$results[$i]->price,
                'qty'=>$results[$i]->qty,
                'total'=>$results[$i]->qty*$results[$i]->price


                // Add more rows here if needed
            ];*/
            //reset all
           DB::update("update safariProducts set qty=qty+:qty,SoldOut=SoldOut-:SoldOut,TotSoldAmount=TotSoldAmount-:TotSoldAmout where safariId=:safariId and productCode=:productCode limit 100 ",array(
                   "qty"=>$results[$i]->qty,
                   "SoldOut"=>$results[$i]->qty,
                   "TotSoldAmout"=>$results[$i]->total,
                   "safariId"=>$results[$i]->SafariId,
                   "productCode"=>$results[$i]->productCode

            ));
            DB::delete("delete from orderhistories where uid=:uid and productCode=:productCode limit 50",array(
                "uid"=>$input['uid'],
                "productCode"=>$results[$i]->productCode


                ));
        }
       // $input['uidComeFromOrderEdit']=$input['uid'];
       // $current_qty=totalqty
       $input['currentQtyOfOrder']=$totalQty;
       $input["orderIdFromEdit"]=$orderId;
       $input['statusForm']="editOrder";

if($results){
    if($input['currentQtyOfOrder']>0){
        return $this->placeOrder($input);
    }

}

}
public function deleteTSingleOrder($input){
    //$req_qty=$input['req_qty'];
    $productCode=$input['productCode'];
   // $current_qty=$input['current_qty'];
    $uid=$input['uid'];
    $subscriber=Auth::user()->subscriber;
    $results=DB::select("select *FROM
    orderhistories
WHERE
    productCode='$productCode' AND
    uid='$uid' AND
    subscriber='$subscriber'");


    $data=[];
    $ids=[];
    $orderId="OrderId";
      $limitData=count($results);
         $totalQty=0;
    for($i=0;$i<$limitData;$i++)
    {
        $totalQty+=$results[$i]->qty;
        $id=$results[$i]->id;
        $ids[]=$results[$i]->id;
        $orderId=$results[$i]->uid;

       DB::update("update safariProducts set qty=qty+:qty,SoldOut=SoldOut-:SoldOut,TotSoldAmount=TotSoldAmount-:TotSoldAmout where safariId=:safariId and productCode=:productCode limit 100 ",array(
               "qty"=>$results[$i]->qty,
               "SoldOut"=>$results[$i]->qty,
               "TotSoldAmout"=>$results[$i]->total,
               "safariId"=>$results[$i]->SafariId,
               "productCode"=>$results[$i]->productCode

        ));
        DB::delete("delete from orderhistories where uid=:uid and productCode=:productCode limit 50",array(
            "uid"=>$input['uid'],
            "productCode"=>$results[$i]->productCode


            ));
    }
    $input['currentQtyOfOrder']=$totalQty;
    if($results){
        if($input['currentQtyOfOrder']>0){
            $checkProduct=DB::update("update products set qty_sold=qty_sold-$totalQty where subscriber=:subscriber and productCode=:productCode  limit 1",array(
                "productCode"=>$productCode,
                "subscriber"=>Auth::user()->subscriber
             ));
             if($checkProduct)
             {
                return response([
                    "status"=>true,
                    "result"=> $checkProduct,

                ],200);
             }
             else{
                return response([
                    "status"=>false,
                    "result"=>$checkProduct,

                ],200);
             }
        }

    }

}
public function deleteTOrder($input){


   // $current_qty=$input['current_qty'];
    $uid=$input['uid'];
    $subscriber=Auth::user()->subscriber;
    $results=DB::select("select *FROM
    orderhistories
WHERE
    uid='$uid' AND
    subscriber='$subscriber'");


    $data=[];
    $ids=[];
    $orderId="OrderId";
      $limitData=count($results);
         $totalQty=0;
    for($i=0;$i<$limitData;$i++)
    {
        $totalQty+=$results[$i]->qty;
        $id=$results[$i]->id;
        $ids[]=$results[$i]->id;
        $orderId=$results[$i]->uid;
        $qty=$results[$i]->qty;

       DB::update("update safariProducts set qty=qty+:qty,SoldOut=SoldOut-:SoldOut,TotSoldAmount=TotSoldAmount-:TotSoldAmout where safariId=:safariId and productCode=:productCode limit 100 ",array(
               "qty"=>$results[$i]->qty,
               "SoldOut"=>$results[$i]->qty,
               "TotSoldAmout"=>$results[$i]->total,
               "safariId"=>$results[$i]->SafariId,
               "productCode"=>$results[$i]->productCode

        ));
        DB::delete("delete from orderhistories where uid=:uid and productCode=:productCode limit 50",array(
            "uid"=>$input['uid'],
            "productCode"=>$results[$i]->productCode


            ));

            $checkProduct=DB::update("update products set qty_sold=qty_sold-$qty where subscriber=:subscriber and productCode=:productCode  limit 1",array(
                "productCode"=>$results[$i]->productCode,
                "subscriber"=>Auth::user()->subscriber
             ));

           if ($i == ($limitData-1)) {
                return response([
                    "status"=>true,
                    "result"=>$checkProduct,

                ],200);

            }
    }




}
public function EditOGOrder($input){

}

    public function testCancelOrder(){


    }
public function testSubmitOrder(){

    $check=DB::update("update users set  notify");
    $createOrder=DB::table("Orders")
        ->insert();
    $addrecords="admnin_records";


}

public function ViewTempOrder($input){//make sure order must not be more than 30 minutes

    try {
        $uid = $input['uid'];
        try {
            $check = DB::select("
                SELECT
                MAX(users.name) AS name,
                MAX(orderhistories.uid) AS uid,
                orderhistories.productCode,
                MAX(products.productName) AS productName,
                    MAX(products.pcs) AS pcs,
                    SUM(orderhistories.qty) AS totalQty,
                    SUM(orderhistories.total) AS totalAmount,
                    SUM(orderhistories.qty_count) AS totalCount
                FROM orderhistories
                INNER JOIN products ON orderhistories.productCode = products.productCode
                INNER JOIN users ON orderhistories.userid = users.uid
                WHERE uid = :uid
                GROUP BY orderhistories.productCode order by orderhistories.id desc
                LIMIT 25
            ", ['uid' => $uid]);
        } catch (\Exception $e) {
            return response()->json([
                'error' => 'An error occurred',
                'errorPrint' => $e->getMessage(),
                'errorCode' => $e->getLine(),
            ], 500);
        }

        if($check)
        {
           return response([
               "status"=>true,
               "result"=>$check,

           ],200);
        }
        else{
           return response([
               "status"=>true,
               "result"=>0,

           ],200);
        }

    } catch (\Exception $e) {
        return response()->json(['error' => 'An error occurred', 'errorPrint' => $e->getMessage(), 'errorCode' => $e->getLine()], 500);
    }







}

public function ViewUserTempOrder($input){//make sure order must not be more than 30 minutes

    try {

        try {
            $check = DB::select("
            SELECT
                MAX(users.name) AS name,
                MAX(orderhistories.uid) AS uid,
                orderhistories.productCode,
                MAX(products.productName) AS productName,
                MAX(orderhistories.price) AS price,
                MAX(products.pcs) AS pcs,
                SUM(orderhistories.qty) AS totalQty,
                SUM(orderhistories.total) AS totalAmount,
                SUM(orderhistories.qty_count) AS totalCount
            FROM orderhistories
            INNER JOIN products ON orderhistories.productCode = products.productCode
            INNER JOIN users ON orderhistories.userid = users.uid
            WHERE orderhistories.order_creator = :orderCreator
                AND orderhistories.subscriber = :subscriber
                AND orderhistories.paidStatus='none'
            GROUP BY orderhistories.productCode order by orderhistories.id desc
            LIMIT 25
        ", [

            'orderCreator' => Auth::user()->uid,
            'subscriber' => Auth::user()->subscriber,
        ]);
        } catch (\Exception $e) {
            return response()->json([
                'error' => 'An error occurred',
                'errorPrint' => $e->getMessage(),
                'errorCode' => $e->getLine(),
            ], 500);
        }

        if($check)
        {
           return response([
               "status"=>true,
               "result"=>$check,

           ],200);
        }
        else{
           return response([
               "status"=>true,
               "result"=>0,

           ],200);
        }

    } catch (\Exception $e) {
        return response()->json(['error' => 'An error occurred', 'errorPrint' => $e->getMessage(), 'errorCode' => $e->getLine()], 500);
    }







}

public function viewTotalSales(){ //this will view All sales
    DB::select("select *from admnin_records where uid=:uid and status=:status and subscriber=:subscriber order by id desc limit 25",[
         "uid"=>Auth::user()->uid,
        "subscriber"=>Auth::user()->subscriber,
        "status"=>'sales'
    ]);
}
public function viewSaleSyst(){ //this will view All sales based on systemId //not done
    DB::select("select *from admnin_records where uid=:uid and status=:status and subscriber=:subscriber order by id desc limit 25",[
         "uid"=>Auth::user()->uid,
        "subscriber"=>Auth::user()->subscriber,
        "status"=>'sales'
    ]);
}

    //my code of buying and calculator

    //stock Count//

    public function ViewOrderDeliver($input){

        $check=DB::select("SELECT oh.qty_count, s.sumqty AS mySumqty_count
        FROM orderhistories oh
        INNER JOIN (
            SELECT COALESCE(SUM(qty), 0) AS sumqty
            FROM shouts
            WHERE shouts.userid != 'test'
            AND shouts.productCode='viva_1693508831'

        ) AS s ON 1 = 1
        WHERE oh.uid = 'O4Pft' AND productCode='keb'");

    }


    public function SubmitOrder($input){
        $check_InputData=$input['all_total']-$input['inputData'];//all_total :niyo total ya orders,custom_price or inputData=niyo client yishyuye cash

        if($input['all_total']>$input['inputData'])
        {
            return $this->admin_record($input);
        }
        else{
            $this->admin_record($input);
            //return (new ParticipateController)->participate($input);
        }

//$check_InputData<=0?(new ParticipateController)->participate($input):$this->notparticipate();//means client azaba yishyuye yose nta deni afite

    }

    public function admin_record($input){

        $uidCreator=Auth::user()->uid; //is the one who will pay money to client when he will withdraw
        $subscriber=Auth::user()->subscriber;
        $systemUid=$input['systemUid'];
        try{


            $check=DB::transaction(function () use ($input) {
                $uidCreator=Auth::user()->uid; //is the one who will pay money to client when he will withdraw
            $subscriber=Auth::user()->subscriber;
            $systemUid=$input['systemUid'];

    //
    DB::update("update Orderhistories set

    all_total=:all_total,custom_price=:custom_price,
    paidStatus ='checked'
    where uid=:uid and userid=:userid limit 100",array(
        "uid"=>$input["OrderId"],
        "userid"=>$input["uidUser"],
        "all_total"=>$input['all_total'],
        "custom_price"=>$input['inputData']

    ));

    $paidStatus=($input['inputData']==$input['all_total'])?'paid':($input['inputData']>$input['all_total'])?'paidReturn':'dettes';
    $json_array =  [
        [
        "uid"=>$input["OrderId"],//orderId
        "total"=>$input['all_total'],
        "paid"=>$input['inputData'],
        "debt"=>$input['all_total']-$input['inputData'],
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
        "paid"=>$input['inputData'],
        "debt"=>$input['all_total']-$input['inputData'],
        "paidStatus"=>$paidStatus,
        "systemUid"=>$systemUid,
        "uidUser"=>($input['uidUser']??$uidCreator),
        "uidCreator"=>$uidCreator,
        "subscriber"=>$subscriber,
        "temporalData"=>json_encode($json_array),
        "commentData"=>$input['commentData']??'none',
        "created_at"=>$this->today,
        "updated_at"=>$this->today
    ] );



    /*$check=DB::select("select status from admnin_records where uid=:uid and systemUid=:systemUid limit 1",array(
        "uid"=>$uidCreator,
        "systemUid"=>$input['systemUid']
       ));*/

       //note I must add form vaildations to check if it is number
        $check=DB::update("update admnin_records set balance=balance+:balance,dettes=dettes+:dettes where uid=:uid and systemUid=:systemUid limit 1",array(
            "uid"=>$uidCreator,
            "systemUid"=>$input['systemUid'],
            "balance"=>$input['all_total'],
            "dettes"=>($input['all_total']-$input['inputData'])
        ));
        if($check)
        {

        }
        else{
            DB::table("admnin_records")
            ->insert([
                "uid"=>$uidCreator,
                "subscriber"=>$subscriber,
                "systemUid"=>$input['systemUid'],
                "status"=>'sales',
                "balance"=>$input['all_total'],
                "dettes"=>($input['all_total']-$input['inputData'])

            ]);
        }



    //







            });

            // Execute the prepared statement


            //DB::commit();// Use DB::unprepared for multi-statement queries



            // Code executed successfully, return a JSON response
            return response()->json(['message' => 'Data inserted successfully',"status"=>true], 200);
            } catch (\Exception $e) {
                DB::rollback();
               // throw $e;
                return response()->json(["status"=>false,'error' => 'An error occurred',
            'errorPrint'=>$e->getMessage()], 500); // Return an error JSON response
            }

    }

    public function notparticipate(){
        return response([
            "status"=>false,
            "result"=>0,

        ],200);
    }
    public function GetAllDebts($input){
        try {

            //code...
        } catch (\Throwable $th) {
            //throw $th;
        }

    }
    public function GetDebt($input){//when you are going to pay,this will return only ID of User and Total Debt of That company

        try {
            //code..
            $phoneNumber=$input['PhoneNumber']??'none';
        $cardUid=$input['cardUid']??'none';
        if(($phoneNumber && $cardUid)==='none')
        {
            return response([

                "status"=>false,
                "message"=>"something went wrong,please use your Card or use Phone Number",
                "result"=>"",

            ],200);
        }
        else{

            $Query1A="WHERE orders.paidStatus='dettes' and users.PhoneNumber =:PhoneNumber and orders.subscriber=:subscriber
            GROUP BY users.uid,users.name";
            $varArrayA=array(
                "subscriber"=>Auth::user()->subscriber,
                "PhoneNumber"=>$phoneNumber
             );
             $Query1B="WHERE orders.paidStatus='dettes' and users.carduid =:cardUid and orders.subscriber=:subscriber
             GROUP BY users.uid,users.name";
             $varArrayB=array(
                 "subscriber"=>Auth::user()->subscriber,
                 "cardUid"=>$cardUid
              );
            list($varInput,$query,$arrayValue)=($phoneNumber!='none')?[$phoneNumber,$Query1A,$varArrayA]:[$cardUid,$Query1B,$varArrayB];
            $check = DB::select("SELECT users.uid AS uidUser, users.name, SUM(orders.debt) as debt
            FROM orders
            INNER JOIN users ON orders.uidUser = users.uid
            $query",$arrayValue);

            if($check)
            {
                return response([

                    "status"=>true,
                    "message"=>"get debt",
                    "result"=>$check,

                ],200);
            }
            else{
                return response([

                    "status"=>false,
                    "message"=>($phoneNumber!='none')?"Invalid Phone Number or does not Exist":'Card does not Exist',
                    "result"=>$check,

                ],200);
            }

        }



        }  catch (\Exception $e) {
            DB::rollback();
           // throw $e;
            return response()->json(['error' => 'An error occurred',
        'errorPrint'=>$e->getMessage(),"errorCode"=>$e->getLine()], 500); // Return an error JSON response
        }

    }
    public function PaidDette($input){




     return $this->dettesPaid($input);
    // return (new ParticipateController)->participate($input);

    }
    public function dettesPaid($input){
        $subscriber=Auth::user()->subscriber;
        $uidUser=$input['uidUser'];
        $inputData=$input['inputData'];


        try{

            $check=DB::transaction(function () use ($input) {
             $uidUser=$input['uidUser'];

             $inputData=$input['inputData'];
             $all_total=$input['all_total'];
             $ref=$input['ref']??'none';
             $systemUid=$input['systemUid'];
             $uidCreator=Auth::user()->uid;
             $subscriber=Auth::user()->subscriber;
             $commentData=$input["commentData"]??'none';
             $status=$input["status"]??'PaidDette';
         // this query will give you a list of how much you will pay every Admin in This Company by dividing according,based on every someone you have debts
         $data=DB::select("SELECT
         id,
         paid,
         uid,
         uidCreator,
         total,
         systemUid,
         ROUND(debt / (SELECT SUM(debt) FROM orders) * :inputData) AS paidAmount
     FROM orders where uidUser=:uidUser and subscriber=:subscriber and paidStatus='dettes' limit 50 ",array(
        "inputData"=>$inputData,
        "uidUser"=>$uidUser,
        "subscriber"=>$subscriber
     ));

     for($i=0;$i<count($data);$i++)
     {
         /*$json_array =  [
             [
                "uid"=>$data[$i]->uid,//orders ID
                 "uidUser"=>$uidUser,
                 "uidReceiver"=>$data[$i]->uidCreator,//owner of dettes
                 "uidCreator"=>$uidCreator,//who received amount as admin
                 "amount"=>$data[$i]->paidAmount,//amount
                 "InputAmount"=>$inputData,//amount Submitted
                 "paidStatus"=>(($data[$i]->uidCreator==$uidCreator?'paidReceived':'PaidAdminNotReceived')),//
                 "ref"=>$input['ref']??'none',
                 "systemUid"=>$data[$i]->systemUid,
                 "subscriber"=>$subscriber,
                 "commentData"=>$input['commentData']??'none',
                 "created_at"=>$this->today,
                 "updated_at"=>$this->today
             ]
         ];
         DB::table("paid_dettes")
         ->insert([
             "uid"=>$data[$i]->uid,//orders ID
             "uidUser"=>$uidUser,
             "uidReceiver"=>$data[$i]->uidCreator,//owner of dettes
             "uidCreator"=>$uidCreator,//who received amount as admin
             "amount"=>$data[$i]->paidAmount,//amount
             "paidStatus"=>(($data[$i]->uidCreator==$uidCreator?'paidReceived':'PaidAdminNotReceived')),//
             "temporalData"=>json_encode($json_array),
             "systemUid"=>$data[$i]->systemUid,
             "subscriber"=>$subscriber,
             "commentData"=>$input['commentData']??'none',
             "created_at"=>$this->today
         ]);*/
         DB::update("UPDATE orders
         SET debt = (debt - ROUND(debt / (SELECT SUM(debt) FROM orders) * $inputData)),
         paidStatus = (CASE
                          WHEN (debt-(ROUND(debt / (SELECT SUM(debt) FROM orders) * $inputData))) <= 0 THEN 'paid'
                          ELSE paidStatus
                      END)

         WHERE uidUser = :uidUser AND paidStatus = 'dettes' AND subscriber=:subscriber
         LIMIT 50", array(

             "uidUser" => $uidUser,
             "subscriber"=>Auth::user()->subscriber
         ));

     }
     return array(
        //"result"=>$results[0]->id,
        "datacount"=>count($data)
     );


        });

        return response()->json(['message' => 'Payment Received',"data"=>$check], 200);

            } catch (\Exception $e) {
                     DB::rollback();
                    // throw $e;
                     return response()->json(['error' => 'An error occurred',
                 'errorPrint'=>$e->getMessage(),"errorCode"=>$e->getLine()], 500); // Return an error JSON response
                 }
    }

    public function repaidDebt($input){//when admin received amount that is not belong to him


    }
    public function OrderViewCount($input){
        try {

            try {
                $check = DB::select("
                SELECT
                   orderhistories.uid as OrderId,
                    MAX(users.name) AS name,

                    SUM(orderhistories.qty) AS totalQty,
                    SUM(orderhistories.total) AS totalAmount,
                    SUM(orderhistories.qty_count) AS totalCount
                FROM orderhistories

                INNER JOIN users ON orderhistories.userid = users.uid
                WHERE orderhistories.subscriber=:subscriber
                    AND orderhistories.paidStatus='checked'
                    AND orderhistories.status = 'Open'
                GROUP BY orderhistories.uid
                ORDER BY orderhistories.id DESC
                LIMIT 100
            ", [
                'subscriber'=>Auth::user()->subscriber,
            ]);

            } catch (\Exception $e) {
                return response()->json([
                    'error' => 'An error occurred',
                    'errorPrint' => $e->getMessage(),
                    'errorCode' => $e->getLine(),
                ], 500);
            }

            if($check)
            {
               return response([
                   "status"=>true,
                   "result"=>$check,

               ],200);
            }
            else{
               return response([
                   "status"=>true,
                   "result"=>0,

               ],200);
            }

        } catch (\Exception $e) {
            return response()->json(['error' => 'An error occurred', 'errorPrint' => $e->getMessage(), 'errorCode' => $e->getLine()], 500);
        }
    }
    public function StockCount($input){//count when product is out of stocks



        try {
            $check=DB::transaction(function () use ($input) {//

                $uidTransport=$input['uidTransport']??'John';//ubitwaye
                $qty_Transport=$input['qty_Transport']??'1';
                $productCode=$input['productCode'];
                $stockName=$input['stockName']??'Nari Hotel';
                $stockdeliver=Auth::user()->uid;//ubitanze
                $ref=$input['ref'];//ref ingana na UId yiyo sales
               //ref ingana na UId yiyo sales
                $status=strtolower($input['status']);//delivered,error,return,reverse
                $comment=$input['comment']??'none';//delivered,error,return,reverse
                $uid=$input["uid"];


                DB::select("SET @requested_qty = ?", [$qty_Transport]);

                $results = DB::select("
                SELECT
                id,
                productCode,
                SafariId,
                qty_count AS prevqty,
                CASE
                    WHEN @requested_qty >= qty_count THEN qty
                    ELSE @requested_qty
                END AS qty_count,
                CASE
                    WHEN @requested_qty >= qty_count THEN 0
                    ELSE @requested_qty - qty_count
                END AS remaining,
                CASE
                    WHEN @requested_qty >= qty_count THEN 'complete'
                    ELSE 'Open'
                END AS new_status,


                @requested_qty := GREATEST(@requested_qty - qty_count, 0) AS updated_requested_qty

            FROM
                orderhistories
            WHERE
                productCode = '$productCode' AND
                uid='$uid' AND
                status ='Open' AND
                paidStatus ='Checked' AND
                @requested_qty > 0
            ORDER BY
                id;
                ");

                 if($results)
                 {
                    $limitData=count($results);
                    for($i=0;$i<$limitData;$i++)
                    {
                        $safariId=$results[$i]->SafariId;
                        $remaining=abs($results[$i]->remaining);
                        $qty_og=$results[$i]->prevqty;
                        $qtyCount=$results[$i]->qty_count;
                        $status=$results[$i]->new_status;
                        $id=$results[$i]->id;
                        $checks=DB::update("UPDATE orderhistories
        SET
            OrderData = JSON_ARRAY_APPEND(
                OrderData,
                '$',
                JSON_OBJECT(
                    'uidTransport', '$uidTransport',
                    'qty_Transport','$qty_Transport',
                    'qty_og','$qty_og',
                    'qtyCount','$qtyCount',
                    'remaining','$remaining',
                    'productId', '$productCode',
                    'stockName', '$stockName',
                    'stockdeliver', '$stockdeliver',
                    'safariId', '$safariId',

                    'ref', '$ref',
                    'status', '$status',
                    'comment', '$comment',
                    'created_at','$this->today'
                )
            ),
           status='$status',
           qty_count='$remaining'
            WHERE
                id = $id AND
                uid='$uid' AND
                status ='Open' AND
                paidStatus ='Checked' limit $limitData;");
                    }
                    return $checks;
                }
                 else{
return $results;
                 }


            });

            return response([

                "status"=>true,
                "result"=>$check,





                ],200);

        } catch (\Exception $e) {
            DB::rollback();
            // throw $e;
             return response()->json(['error' => 'An error occurred',
         'errorPrint'=>$e->getMessage(),"errorCode"=>$e->getLine()], 500); // Return an error JSON response
        }





    }
    //stock Count//

    public function repaidUser($input){

        DB::table("repaid_users")
        ->insert([
            "uid"=>$uidCreator,
            "uidPaid"=>$input['uidPaid'],
            "amount"=>$input['amount'],
            "status"=>$input['status'],
            "signature"=>$input['signature']??'none',
            "purpose"=>$input['purpose'],
            "commentData"=>$input['commentData'],
            "created_at"=>$this->today

        ]);
    }
    public function ConfirmRepaidUser($input){

       DB::update("update repaid_users set uidReceiver=:uidReceiver,status=:status,updated_at=:updated_at where uid=:uid limit 1",array(
        "uid"=>$input['uid'],
        "status"=>$input["status"],
        "uidReceiver"=>Auth::user()->uid,
        "updated_at"=>$this->today,
       ));
    }

    public function addDepense($input){

        try{


        $check=DB::transaction(function () use ($input) {
            $uidUser=Auth::user()->uid;
            $systemUid="GeneralSpend";
            $check=DB::table("depenses")
            ->insert([
                "uid"=>$uidCreator,
                "uidUser"=>$input['uidUser']??Auth::user()->uid,
                "amount"=>$input['amount'],
                "uidCreator"=>Auth::user()->uid,

                "status"=>$input['status'],

                "purpose"=>$input['purpose'],
                "commentData"=>$input['commentData'],
                "created_at"=>$this->today

            ]);

        if($check1){
           $check=DB::update("update admnin_records set balance=balance+:balance where uid=:uid and systemUid=:systemUid limit 1",array(
            "balance"=>$input['balance'],
            "uid"=>$uidUser,
            "systemUid"=>$systemUid,
           ));

           if($check){
            return array(
                "status"=>true,
                "message"=>"Finish update records"
            );
           }
           else{
            DB::table("admnin_records")
            ->insert(
                [
                    "uid"=>Auth::user()->uid,
                    "systemUid"=>$systemUid,
                    "balance"=>$input['balance'],
                    "created_at"=>$this->today
                ]
                );

           }
           return array(
            "status"=>true,
            "message"=>"Finish add New admnin_records"
        );
         }
         else{
           return array(
               "message"=>"Something went Wrong"
           );
         }
        //
    });


    return response([
       "status"=>true,
       "result"=>$check,

   ],200);


                } catch (\Exception $e) {
                    DB::rollback();
                   // throw $e;
                    return response()->json(['error' => 'An error occurred',
                'errorPrint'=>$e->getMessage()], 500); // Return an error JSON response
                }
    }

    public function ViewDepense($input){
     DB::select("select uidUser,amount,purpose from depenses where uidUser=:uidUser",array(
        "uidUser"=>Auth::user()->uid
     ));
    }

    //workers Code  Not to avoid slow app when view Worker it is where it may calculate everything
    public function AddWorker($input){
        DB::table("workers")
        ->insert(
            [
                "uidUser"=>$input['uidUser'],
                "uidCreator"=>Auth::user()->uid,
                "amount"=>$input['amount'],
                "position"=>$input['position'],
                "jobContract"=>$input['jobContract'],
                "systemUid"=>$input['systemUid'],//AppName
                "started_at"=>$input['started_at'],//AppName
                "paid_at"=>$input['paid_at'],//AppName
                "status"=>$input['status'],
                "commentData"=>$input['commentData'],
                "created_at"=>$this->today
            ]
            );
    }
    public function calculateSalary($input){//workers not done
        $selectedTime = "2018-02-17 9:15:00";
        $endTime = strtotime("+24 hours", strtotime($selectedTime));
        echo date('Y-m-d h:i:s', $endTime);
        try{


            $check=DB::transaction(function () use ($input) {
                DB::update("update workers set datePaid_at=");

            if($check1){
               $check=DB::update("update admnin_records set balance=balance+:balance where uid=:uid and systemUid=:systemUid limit 1",array(
                "balance"=>$input['balance'],
                "uid"=>$uidUser,
                "systemUid"=>$systemUid,
               ));

               if($check){
                return array(
                    "status"=>true,
                    "message"=>"Finish update records"
                );
               }
               else{
                DB::table("admnin_records")
                ->insert(
                    [
                        "uid"=>Auth::user()->uid,
                        "systemUid"=>$systemUid,
                        "balance"=>$input['balance'],
                        "created_at"=>$this->today
                    ]
                    );

               }
               return array(
                "status"=>true,
                "message"=>"Finish add New admnin_records"
            );
             }
             else{
               return array(
                   "message"=>"Something went Wrong"
               );
             }
            //
        });


        return response([
           "status"=>true,
           "result"=>$check,

       ],200);


                    } catch (\Exception $e) {
                        DB::rollback();
                       // throw $e;
                        return response()->json(['error' => 'An error occurred',
                    'errorPrint'=>$e->getMessage()], 500); // Return an error JSON response
                    }
    }
    //workers Code

}