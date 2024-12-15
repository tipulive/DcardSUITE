<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Str;
use DB;
use Auth;

class TransportController extends Controller
{
    //
    public function __construct()
    {
        date_default_timezone_set(env('TIME_ZONE'));
        $this->today = date('Y-m-d H:i:s', time());
        $this->today2 = date('d-m-Y H:i:s', time());
        $this->curdate=date('Y-m-d', time());
        $this->Appstate=env('APP_LIVE')?env('APP_PRO'):env('APP_DEV');
        $this->AppName=env('APP_NAME');

        $this->otp='1 hours';
      // $this->otp='20 seconds';//test purpose
        $this->email_confirm='24 hours';
        $this->Admin_Auth_error="You Are not authenticate please Request Permission to Admin";
        $this->Admin_Auth_result_error="0";//Admin auth result zero

    }

    public function ViewTravelBooked($input){

    }
    public function viewTravelSales($input){//this is booked and Paid

        try {
            //code...
            $advancedSearch=strtolower($input["advancedSearch"]);

          $item = strtolower($input["name"]??'none');
          $itemSearch='%'.$item.'%';
          $searchOption=($input["searchOption"]=='name'|| $input["searchOption"]=='orderid' || $input["searchOption"]=='true')?$input["searchOption"]:"false";
          $searchQuery=(object)array(
           "true"=>array(
            "DownQuerySearch"=>"AND users.name LIKE :Name",
            "paramSearch"=>array(
                'Name'=>$itemSearch
            ),
            "groupByLimit"=>"GROUP BY orders.id
          LIMIT 10"

           ),
           "name"=>array(
            "DownQuerySearch"=>"AND users.name LIKE :Name",
            "paramSearch"=>array(
                'Name'=>$itemSearch
            ),
            "groupByLimit"=>"GROUP BY orders.id
          LIMIT 10"

           ),
           "orderid"=>array(
            "DownQuerySearch"=>"AND orders.uid LIKE :orderId",
            "paramSearch"=>array(
                'orderId'=>$itemSearch
            ),
            "groupByLimit"=>"GROUP BY orders.id
          LIMIT 10"

           ),
           "false"=>array(
            "DownQuerySearch"=>"",
            "paramSearch"=>array(

            ),
            "groupByLimit"=>"GROUP BY orders.id
            ORDER BY orders.id DESC
          LIMIT 100"
           ),
         );
         $DownQuerySearch=$searchQuery->{$searchOption}["DownQuerySearch"];
         $paramSearch=$searchQuery->{$searchOption}["paramSearch"];
         $groupByLimitSeach=$searchQuery->{$searchOption}["groupByLimit"];
          $isQuery=(object)array(
            "mysales"=>array(
               "TopQuery"=>"Max(admnin_records.balance) AS saleBalance,
                MAX(orders.total) AS totalPaid,
                MAX(orders.created_at) AS created_at,
                MAX(orders.paidStatus) as paidStatus",
                "DownQuery"=>"WHERE orders.subscriber = :subscriber
                AND orders.uidCreator=:uidCreator
                AND admnin_records.status ='Sales'
                AND admnin_records.subscriber=:adminSubscriber
                $DownQuerySearch
                ",
                "params"=>array(
                    'subscriber' => Auth::user()->subscriber,
                    'adminSubscriber' => Auth::user()->subscriber,
                    'uidCreator' => Auth::user()->uid,


                )


                ),
            "today"=>array(
                "TopQuery"=>"Max(client_orders.price) as saleBalance,
                MAX(orders.total) AS totalPaid,
                MAX(orders.created_at) AS created_at,
                MAX(orders.paidStatus) as paidStatus",
                "DownQuery"=>"
                INNER JOIN (
                   SELECT SUM(total) AS saleBalance
                   FROM orders where orders.uidCreator = :uidCreatorCount
                   AND (DATE(orders.created_at) =CURDATE())
               ) AS total_orders
               WHERE orders.subscriber = :subscriber
                 AND orders.uidCreator = :uidCreator
                 AND admnin_records.status ='Sales'
                 AND admnin_records.subscriber=:adminSubscriber
                 AND (DATE(orders.created_at) = CURDATE())
                 $DownQuerySearch
                 "

                 ,
                 "params"=>array(
                    'subscriber' =>Auth::user()->subscriber,
                    'adminSubscriber'=>Auth::user()->subscriber,
                    'uidCreator'=>Auth::user()->uid,
                    'uidCreatorCount'=>Auth::user()->uid,

                )


                 ),
            "week"=>array(
                "TopQuery"=>"Max(total_orders.saleBalance) as saleBalance,
                MAX(orders.total) AS totalPaid,
                MAX(orders.created_at) AS created_at,
                MAX(orders.paidStatus) as paidStatus",

                "DownQuery"=>"
                INNER JOIN (
                   SELECT SUM(total) AS saleBalance
                   FROM orders where orders.uidCreator = :uidCreatorCount
                   AND (YEARWEEK(orders.created_at) = YEARWEEK(NOW()))
               ) AS total_orders
               WHERE orders.subscriber = :subscriber
                 AND orders.uidCreator = :uidCreator
                 AND admnin_records.status ='Sales'
                 AND admnin_records.subscriber=:adminSubscriber
                 AND (YEARWEEK(orders.created_at) = YEARWEEK(NOW()))
                 $DownQuerySearch
                 "

                 ,
                 "params"=>array(
                    'subscriber' =>Auth::user()->subscriber,
                    'adminSubscriber'=>Auth::user()->subscriber,
                    'uidCreator'=>Auth::user()->uid,
                    'uidCreatorCount'=>Auth::user()->uid,



                )

                 ),

            "month"=>array(
                            "TopQuery"=>"Max(total_orders.saleBalance) as saleBalance,
                             MAX(orders.total) AS totalPaid,
                             MAX(orders.created_at) AS created_at,
                             MAX(orders.paidStatus) as paidStatus",
                             "DownQuery"=>"
                             INNER JOIN (
                                SELECT SUM(total) AS saleBalance
                                FROM orders where orders.uidCreator = :uidCreatorCount
                                AND (YEAR(orders.created_at) = YEAR(CURDATE()) AND MONTH(orders.created_at) = MONTH(CURDATE()))
                            ) AS total_orders
                             WHERE orders.subscriber = :subscriber
                             AND orders.uidCreator = :uidCreator
                             AND admnin_records.status ='Sales'
                             AND admnin_records.subscriber=:adminSubscriber
                             AND (YEAR(orders.created_at) = YEAR(CURDATE()) AND MONTH(orders.created_at) = MONTH(CURDATE()))
                             $DownQuerySearch
                             "

                             ,
                             "params"=>array(
                                 'subscriber' =>Auth::user()->subscriber,
                                 'adminSubscriber'=>Auth::user()->subscriber,
                                 'uidCreator'=>Auth::user()->uid,
                                 'uidCreatorCount'=>Auth::user()->uid,

                             )


                             ),
            "year"=>array(
                "TopQuery"=>"Max(total_orders.saleBalance) as saleBalance,
                MAX(orders.total) AS totalPaid,
                MAX(orders.created_at) AS created_at,
                MAX(orders.paidStatus) as paidStatus",
                "DownQuery"=>"
                INNER JOIN (
                   SELECT SUM(total) AS saleBalance
                   FROM orders where orders.uidCreator = :uidCreatorCount
                   AND (YEAR(orders.created_at) = YEAR(CURDATE()))
               ) AS total_orders
                 WHERE orders.subscriber = :subscriber
                 AND orders.uidCreator = :uidCreator
                 AND admnin_records.status ='Sales'
                 AND admnin_records.subscriber=:adminSubscriber
                 AND (YEAR(orders.created_at) = YEAR(CURDATE()))
                 $DownQuerySearch
                 "

                 ,
                 "params"=>array(
                     'subscriber'=>Auth::user()->subscriber,
                     'adminSubscriber'=>Auth::user()->subscriber,
                     'uidCreator'=>Auth::user()->uid,
                     'uidCreatorCount'=>Auth::user()->uid,

                 )


                 ),
                 "choosedate"=>array(
                    "TopQuery"=>"Max(total_orders.saleBalance) as saleBalance,
                    MAX(orders.total) AS totalPaid,
                    MAX(orders.created_at) AS created_at,
                    MAX(orders.paidStatus) as paidStatus",
                    "DownQuery"=>"
                    INNER JOIN (
                       SELECT SUM(total) AS saleBalance
                       FROM orders where orders.uidCreator = :uidCreatorCount
                       AND (DATE(orders.created_at)=:thisDate)
                   ) AS total_orders
                     WHERE orders.subscriber = :subscriber
                     AND orders.uidCreator = :uidCreator
                     AND admnin_records.status ='Sales'
                     AND admnin_records.subscriber=:adminSubscriber
                     AND (DATE(orders.created_at) =:thisDate2)
                     $DownQuerySearch
                     "

                     ,
                     "params"=>array(
                         'subscriber'=>Auth::user()->subscriber,
                         'adminSubscriber'=>Auth::user()->subscriber,
                         'uidCreator'=>Auth::user()->uid,
                         'uidCreatorCount'=>Auth::user()->uid,
                         'thisDate'=>$input['thisDate'],
                         'thisDate2'=>$input['thisDate']

                     )


                     ),
                     "choosedaterange"=>array(
                        "TopQuery"=>"Max(total_orders.saleBalance) as saleBalance,
                        MAX(orders.total) AS totalPaid,
                        MAX(orders.created_at) AS created_at,
                        MAX(orders.paidStatus) as paidStatus",
                        "DownQuery"=>"
                        INNER JOIN (
                           SELECT SUM(total) AS saleBalance
                           FROM orders where orders.uidCreator = :uidCreatorCount
                           AND (DATE(orders.created_at) BETWEEN :thisDate AND :toDate)
                       ) AS total_orders
                         WHERE orders.subscriber = :subscriber
                         AND orders.uidCreator = :uidCreator
                         AND admnin_records.status ='Sales'
                         AND admnin_records.subscriber=:adminSubscriber
                         AND (DATE(orders.created_at) BETWEEN :thisDate2 AND :toDate2)
                         $DownQuerySearch
                         "

                         ,
                         "params"=>array(
                             'subscriber'=>Auth::user()->subscriber,
                             'adminSubscriber'=>Auth::user()->subscriber,
                             'uidCreator'=>Auth::user()->uid,
                             'uidCreatorCount'=>Auth::user()->uid,
                             'thisDate'=>$input['thisDate'],
                             'thisDate2'=>$input['thisDate'],
                             'toDate'=>$input['toDate'],
                             'toDate2'=>$input['toDate'],

                         )


                         ),







          );
         // $Query=$searchQuery->{$advancedSearch};
         $topQuery=$isQuery->{$advancedSearch}["TopQuery"];
         $downQuery=$isQuery->{$advancedSearch}["DownQuery"];
         $paramsQuery1=$isQuery->{$advancedSearch}["params"];
         $paramsQuery = array_merge($paramsQuery1, $paramSearch);
         $check = DB::select("
         SELECT
             Max(client_orders.uid) as OrderId,
             MAX(users.name) AS name,
             $topQuery


         FROM orders
         INNER JOIN admnin_records ON orders.uidCreator =admnin_records.uid
         INNER JOIN users ON orders.uidUser = users.uid
         $downQuery
         $groupByLimitSeach
     ", $paramsQuery);

        if($check)
        {
            return response([
                "status"=>true,
                "test"=>$this->curdate,
                "down"=>$DownQuerySearch,
               // "parameters"=>$paramSearch,
                "result"=>$check



            ],200);

        }
        else{
           return response([
            "test2"=>$this->curdate,
               "status"=>true,
               "result"=>0,

           ],200);
        }
          } catch (\Exception $e) {
            return response()->json([
                'error' => 'An error occurred',
                'errorPrint' => $e->getMessage(),
                'errorCode' => $e->getLine(),
            ], 500);
        }



    }
    public function searchLocation($input){
        $item = strtolower($input["searchItem"]);
        $itemSearch='%'.$item.'%';
        if(strtolower($input["searchOption"])==strtolower('origin'))
        {
           $check=DB::select("select origin from locations where origin LIKE :origin limit 10",[
           "origin"=>$itemSearch
           ]);
           if($check){
            return response([
                "status" =>true,
                "result"=>$check


            ]);
        }
        else{
            return response([
                "status" =>false,

            ]);
        }

        }else if(strtolower($input["searchOption"])==strtolower('Destination')){
            $check=DB::select("select destination from locations where destination LIKE :destination limit 10",[
                "destination"=>$itemSearch

            ]);

            if($check){
                return response([
                    "status" =>true,
                    "result"=>$check


                ]);
            }
            else{
                return response([
                    "status" =>false,

                ]);
            }

        }
        else{

        }
    }
    public function SearchTransport($input){
        if(strtolower($input["searchOption"])==strtolower('origin'))
        {

        }else if(strtolower($input["searchOption"])==strtolower('Destination')){

        }
        else if(strtolower($input["searchOption"])==strtolower('dateTimeOn')){
            $check=DB::select("select
            Max(admins.CompanyName) as companyName,
            Max(dashtrips.uid) as uid,
            Max(dashtrips.origin) as origin,
            Max(dashtrips.destination) as destination,
            Max(dashtrips.tag) as tag,
            Max(dashtrips.dateOn) as dateOn,
            Max(dashtrips.price) as price,
            Max(dashtrips.seatAV) as seatAv,
            Max(dashtrips.seatCount) as seatCount
            from dashtrips
            inner join admins on dashtrips.subscriber=admins.subscriber and dashtrips.dateOn=:thisDate group by dashtrips.id limit 10

            ",[
                "thisDate"=>$input["dateOn"]
            ]);
            if($check){
                return response([
                    "status" =>true,
                    "result"=>$check


                ]);
            }
            else{
                return response([
                    "status" =>false,

                ]);
            }

        }
        else if(strtolower($input["searchOption"])==strtolower('timeOn')){
            $check=DB::select("select
            Max(admins.CompanyName) as companyName,
            Max(dashtrips.uid) as uid,
            Max(dashtrips.origin) as origin,
            Max(dashtrips.destination) as destination,
            Max(dashtrips.tag) as tag,
            Max(dashtrips.dateOn) as dateOn,
            Max(dashtrips.price) as price,
            Max(dashtrips.seatAV) as seatAv,
            Max(dashtrips.seatCount) as seatCount
            from dashtrips
            inner join admins on dashtrips.subscriber=admins.subscriber and (Time(dashtrips.dateOn)=:thisDate) group by dashtrips.id limit 10

            ",[
                "thisDate"=>$input["dateOn"]
            ]);
            if($check){
                return response([
                    "status" =>true,
                    "result"=>$check


                ]);
            }
            else{
                return response([
                    "status" =>false,

                ]);
            }

        }
        else if(strtolower($input["searchOption"])==strtolower('dateOn')){
            $check=DB::select("select
            Max(admins.CompanyName) as companyName,
            Max(dashtrips.uid) as uid,
            Max(dashtrips.origin) as origin,
            Max(dashtrips.destination) as destination,
            Max(dashtrips.tag) as tag,
            Max(dashtrips.dateOn) as dateOn,
            Max(dashtrips.price) as price,
            Max(dashtrips.seatAV) as seatAv,
            Max(dashtrips.seatCount) as seatCount
            from dashtrips
            inner join admins on dashtrips.subscriber=admins.subscriber and (DATE(dashtrips.dateOn)=:thisDate) group by dashtrips.id limit 10

            ",[
                "thisDate"=>$input["dateOn"]
            ]);
            if($check){
                return response([
                    "status" =>true,
                    "result"=>$check


                ]);
            }
            else{
                return response([
                    "status" =>false,

                ]);
            }

        }
        else if(strtolower($input["searchOption"])==strtolower('combine')){
            $check=DB::select("select
            Max(admins.CompanyName) as companyName,
            Max(dashtrips.uid) as uid,
            Max(dashtrips.origin) as origin,
            Max(dashtrips.destination) as destination,
            Max(dashtrips.tag) as tag,
            Max(dashtrips.dateOn) as dateOn,
            Max(dashtrips.price) as price,
            Max(dashtrips.seatAV) as seatAv,
            Max(dashtrips.seatCount) as seatCount
            from dashtrips
            inner join admins on dashtrips.subscriber=admins.subscriber group by dashtrips.id limit 10

            ");
            if($check){
                return response([
                    "status" =>true,
                    "result"=>$check


                ]);
            }
            else{
                return response([
                    "status" =>false,

                ]);
            }


        }
        else{

        }
    }


    public function fromToTransp($input){

    }
    public function fromDateTransp($input){

    }
    public function fromToCombineTransp($input){

    }
    public function viewSeat(Request $request){
        $uid=$request->input("uid");
        $check=DB::select("select
        Max(dashtrips.seatAV) as seatAv,
        Max(dashtrips.seatCount) as seatCount,
        Max(client_orders.seat) as seatTaken
         from client_orders
         inner join dashtrips on client_orders.uid=dashtrips.uid and client_orders.uid=:uid  group by client_orders.id
         ",[
             "uid"=>$uid
         ]
    );
    if($check){

        $seat =[];

        for($i=0;$i<count($check);$i++)
        {
        //echo $i;
        array_push($seat,$check[$i]->seatTaken);


        }
        $result = range(1,$check[0]->seatAv);
        $resultSeat = array_values(array_diff($result,$seat));
        //print_r($resultSeat);
        return response([
            "status" =>true,
            "result"=>array_map('strval',$resultSeat)


        ]);
    }
    else{

        $result = range(1,$request->input("seatAv"));
        return response([
            "status" =>true,
            "result"=>array_map('strval', $result)



        ]);
    }
    }
    public function BookTicket($input){

        try {
            $checkInsert = DB::table("client_orders")->insert([
                "uid" => $input["uid"],
                "uidSeat" => $input["uid"] . "_" . $input["seat"], // must be unique
                "seat" => $input["seat"], // seats
                "uidUser" => $input["uidUser"] ?? 'none',
                "name" => $input["name"] ?? 'none', // other name in case we want to add name
                "phone" => $input["phone"] ?? 'none', // other Phone
                "uidCreator" => $input["uidCreator"] ?? Auth::user()->uid,
                "subscriber" => $input["subscriber"] ?? Auth::user()->subscriber, // company Cars Name
                "created_at" => $this->today,
            ]);

            if ($checkInsert) {
                $check = DB::update(
                    "update dashtrips set seatCount=seatCount+1 where uid=:uid limit 1",
                    ["uid" => $input["uid"]]
                );

                if ($check) {
                    return response([
                        "status" => true,
                    ]);
                } else {
                    return response([
                        "status" => false,
                    ]);
                }
            }
        } catch (\Illuminate\Database\QueryException $e) {
            // Check if the exception is due to a unique constraint violation
            if ($e->getCode() === '23000') { // 23000 is the SQLSTATE code for unique constraint violations
                $seat = $input["seat"];
                return response([
                    "status" => false,
                    "errorMessage" => "This Seat number $seat is taken, please try another one.",
                ]);
            }

            // Handle other query exceptions if needed
            return response([
                "status" => false,
                "errorMessage" => "An unexpected error occurred.",
            ]);
        }


    }

    public function searchBooked($input){//search Booked without sales

    }




    public function registerVehicle($input){
        $uid=preg_replace('/[^A-Za-z0-9-]/','',$input['carsName']);//generated on production
        //echo $this->today;
        $uid=$uid.""."_".date(time());

        $check=DB::table("cars")
        ->insert([
            "uid"=>$uid,
            "numberPlate"=>$input['numberPlate'],
            "carsName"=>$input['carsName'],
            "numberSeat"=>$input['numberSeat'],
            'commentData'=>$input["CommentData"]??'none',
            "uidCreator"=>Auth::user()->uid,
            "subscriber"=>Auth::user()->subscriber,
            "created_at"=>$this->today



        ]);
        if($check){
            return response([
                "status" =>true,

                "uid"=>$uid
            ]);
        }
        else{
            return response([
                "status" =>false,
                "uid"=>false,
            ]);
        }
    }
    public function createLocation($input){
        $uid="loc".""."_".Str::random(2).""."_".date(time());
        $check=DB::table("locations")
                 ->insert([
                    "uid"=>$uid,
                    "origin"=>$input["origin"],
                    "destination"=>$input["destination"],
                    "price"=>$input["price"],
                    "tag"=>$input["tag"],
                    'commentData'=>$input["CommentData"]??'none',
                    "uidCreator"=>Auth::user()->uid,
                    "subscriber"=>Auth::user()->subscriber,
                    "created_at"=>$this->today
                 ]);

                 if($check){
                    return response([
                        "status" =>true,

                        "uid"=>$uid
                    ]);
                }
                else{
                    return response([
                        "status" =>false,
                        "uid"=>false,
                    ]);
                }


    }
    public function viewSearchLocation(Request $request){
        $input=$request->all();
        $item = strtolower($input["searchItem"]);
        $itemSearch='%'.$item.'%';
        if(strtolower($input["searchOption"])==strtolower('origin'))
        {
           $check=DB::select("select destination,origin,tag,uid from dashtrips where origin LIKE :origin limit 10",[
           "origin"=>$itemSearch
           ]);
           if($check){
            return response([
                "status" =>true,
                "result"=>$check


            ]);
        }
        else{
            return response([
                "status" =>false,

            ]);
        }

        }else if(strtolower($input["searchOption"])==strtolower('Destination')){
            $check=DB::select("select destination,origin,tag,uid from dashtrips where destination LIKE :destination limit 10",[
                "destination"=>$itemSearch

            ]);

            if($check){
                return response([
                    "status" =>true,
                    "result"=>$check


                ]);
            }
            else{
                return response([
                    "status" =>false,

                ]);
            }

        }
        else{

        }

    }

    public function LocationTrip($input){//from locations


        if(strtolower($input["searchOption"])==strtolower('LoadThisLocation'))
        {
            $check=DB::select("select *from locations where uid=:uid and subscriber=:subscriber",[
                "uid"=>$input["uid"],
                "subscriber"=>Auth::user()->subscriber
             ]);
             if($check)
             {
                 return response([
                     "status" =>true,
                     "result"=>$check

                 ]);
             }
             else{
                 return response([
                     "status" =>false,

                 ]);
             }
        }
        else if(strtolower($input["searchOption"])==strtolower('LoadLocations'))
        {
            $check=DB::select("select *from locations where subscriber=:subscriber",[

                "subscriber"=>Auth::user()->subscriber
             ]);
             if($check)
             {
                 return response([
                     "status" =>true,
                     "result"=>$check,
                     "permission"=>Auth::user()->permission??'none',

                 ]);
             }
             else{
                 return response([
                     "status" =>false,
                     "permission"=>Auth::user()->permission??'none',

                 ]);
             }
        }
        else{
            return response([
                "status" =>false,
                "permission"=>Auth::user()->permission??'none',

            ]);
        }

    }
    public function Cars($input){


        if(strtolower($input["searchOption"])==strtolower('LoadThisCar'))
        {
            $check=DB::select("select *from cars where uid=:uid and subscriber=:subscriber",[
                "uid"=>$input["uid"],
                "subscriber"=>Auth::user()->subscriber
             ]);
             if($check)
             {
                 return response([
                     "status" =>true,
                     "result"=>$check,
                     "permission"=>Auth::user()->permission??'none',


                 ]);
             }
             else{
                 return response([
                     "status" =>false,
                     "permission"=>Auth::user()->permission??'none',

                 ]);
             }
        }
        else if(strtolower($input["searchOption"])==strtolower('LoadCars'))
        {
            $check=DB::select("select *from cars where subscriber=:subscriber",[

                "subscriber"=>Auth::user()->subscriber
             ]);
             if($check)
             {
                 return response([
                     "status" =>true,
                     "result"=>$check,
                     "permission"=>Auth::user()->permission??'none',

                 ]);
             }
             else{
                 return response([
                     "status" =>false,
                     "permission"=>Auth::user()->permission??'none',

                 ]);
             }
        }
        else{
            return response([
                "status" =>false,
                "permission"=>Auth::user()->permission??'none',

            ]);
        }

    }
    public function viewAllCars($input){
        $offset=$input["offset"]??"0";
        $check = DB::select("
        SELECT *from  cars
        where subscriber=:subscriber
        ORDER BY id desc
        LIMIT 10 OFFSET $offset
    ", [
        'subscriber' =>Auth::user()->subscriber
    ]);

    if($check){
        return response([
            "status"=>true,
            "todaysDate"=>"$this->today",
            "result"=>$check,
            "permission"=>Auth::user()->permission??'none',


        ],200);

    }
    else{
        return response([
            "status"=>false,
            "status"=>Auth::user()->subscriber,
            "permission"=>Auth::user()->permission??'none',


        ],200);
    }
    }
    public function viewAllLocations($input){
        $offset=$input["offset"]??"0";
        $check = DB::select("
        SELECT *from  locations
        where subscriber=:subscriber
        ORDER BY id desc
        LIMIT 10 OFFSET $offset
    ", [
        'subscriber' =>Auth::user()->subscriber
    ]);

    if($check){
        return response([
            "status"=>true,
            "todaysDate"=>"$this->today",
            "result"=>$check,
            "permission"=>Auth::user()->permission??'none',


        ],200);

    }
    else{
        return response([
            "status"=>false,
            "status"=>Auth::user()->subscriber,
            "permission"=>Auth::user()->permission??'none',


        ],200);
    }
    }
    public function viewAllDashTrip($input){
        $offset=$input["offset"]??"0";
        $check = DB::select("
        SELECT *from  dashtrips
        where subscriber=:subscriber
        ORDER BY id desc
        LIMIT 10 OFFSET $offset
    ", [
        'subscriber' =>Auth::user()->subscriber
    ]);

    if($check){
        return response([
            "status"=>true,
            "todaysDate"=>"$this->today",
            "result"=>$check,
            "permission"=>Auth::user()->permission??'none',


        ],200);

    }
    else{
        return response([
            "status"=>false,
            "status"=>Auth::user()->subscriber,
            "permission"=>Auth::user()->permission??'none',


        ],200);
    }
    }
    public function addDashboardTrip($input){
        $uid="uid".""."_".Str::random(2).""."_".date(time());
        /*$checkCount=DB::select("select count(dateOn) as countN where location=:location and dateOn=:dateOn limit 500",[
            "location"=>$input["location"],
            "dateOn"=>$input["dateOn"]
        ]);*/

        //$countData=($checkCount)?($checkCount[0]->countN)+1:1;
        $check=DB::table("dashtrips")
        ->insert([
                    'uid'=>$uid,
                    //'timeOn'=>$input['timeOn'],//izahagurukira
                    'location'=>$input['location'],//aho igiye
                    'origin'=>$input['origin'],
                    'destination'=>$input['destination'],
                    "tag"=>$input["tag"],
                    'seatAv'=>$input['seatAv'],
                    'price'=>$input['price'],
                    'seatCount'=>$input['seatAv'],//$input['seatCount']??'none',
                    //'sessionKey'=>$countData,
                    'visibleStatus'=>$input['visibleStatus']??'On',
                    'status'=>$input['status']??'none',
                    'dateOn'=>$input['dateOn']??'none',//igihe izagendera
                   'commentData'=>$input["CommentData"]??'none',
                    "uidCreator"=>Auth::user()->uid,
                    "subscriber"=>Auth::user()->subscriber,
                    "created_at"=>$this->today
        ]);
        if($check){

            /*for($i=0;$i<$input['seatAv'];$i++){
                DB::table("seats")
                ->insert([
                    'uid'=>$uid,
                    'dateOn'=>$input['dateOn'],//izahagurukira
                    'location'=>$input['location'],
                    "sessionKey"=>$i+1,//seat key
                    "uidCreator"=>Auth::user()->uid,
                    "subscriber"=>Auth::user()->subscriber,
                ]);
            }*/
            return response([
                "status" =>true,

                "uid"=>$uid
            ]);
        }
        else{
            return response([
                "status" =>false,
                "uid"=>false,
            ]);
        }
    }


}
