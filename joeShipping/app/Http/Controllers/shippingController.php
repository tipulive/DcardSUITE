<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Str;
use DB;
use Auth;

class shippingController extends Controller
{
    //
    public function __construct()
    {
        date_default_timezone_set(env('TIME_ZONE'));
        $this->today = date('Y-m-d H:i:s', time());
        $this->today2 = date('d-m-Y H:i:s', time());
        $this->Appstate=env('APP_LIVE')?env('APP_PRO'):env('APP_DEV');
        $this->AppName=env('APP_NAME');

        $this->otp='1 hours';
      // $this->otp='20 seconds';//test purpose
        $this->email_confirm='24 hours';
        $this->Admin_Auth_error="You Are not authenticate please Request Permission to Admin";
        $this->Admin_Auth_result_error="0";//Admin auth result zero

    }

    public function searchShipUser($input){
        if($input["searchOption"]==='Users')
        {
            $itemSearch=$input["itemSearch"];
        list($queryData, $itemName) = (is_numeric($itemSearch))
        ? (['PhoneNumber', '%' . $itemSearch . '%'])
        : (['name', '%' . $itemSearch . '%']);

        $check=DB::select("select uid,name,PhoneNumber from users where subscriber=:subscriber and $queryData LIKE :itemName limit 10 ",[
            "subscriber"=>Auth::user()->subscriber,
            "itemName" => $itemName,
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
        else if($input["searchOption"]==='Drivers'){
            $itemSearch=$input["itemSearch"];
            list($queryData, $itemName) = (is_numeric($itemSearch))
            ? (['driverTel', '%' . $itemSearch . '%'])
            : (['driverName', '%' . $itemSearch . '%']);

            $check=DB::select("select driverTel,driverName from shippings where subscriber=:subscriber and $queryData LIKE :itemName limit 10 ",[
                "subscriber"=>Auth::user()->subscriber,
                "itemName" => $itemName,
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
        else
        {
            $itemSearch=$input["itemSearch"];
            $itemName= '%' . $itemSearch . '%';
            $queryData=$input["searchOption"];


            $check=DB::select("select *from shippings where subscriber=:subscriber and $queryData LIKE :itemName limit 10 ",[
                "subscriber"=>Auth::user()->subscriber,
                "itemName" => $itemName,
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



    }
    public function shipSearch($input){

        $item = strtolower($input["searchItem"]??'none');
        $itemSearch='%'.$item.'%';

        $searchOption=strtolower($input["searchOption"]??'none');
        $searchQuery=(object)array(
            "true"=>array(
             "DownQuerySearch"=>"AND users.name LIKE :Name",
             "paramSearch"=>array(
                 'Name'=>$itemSearch
             ),
             "groupByLimit"=>"GROUP BY orders.id
           LIMIT 10"

            ),
            "clientname"=>array(
             "DownQuerySearch"=>"AND users.name LIKE :Name",
             "paramSearch"=>array(
                 'Name'=>$itemSearch,
                 'subscriber' => Auth::user()->subscriber
             ),
             "groupByLimit"=>"GROUP BY shippings.id LIMIT 10"

            ),
            "clienttel"=>array(
                "DownQuerySearch"=>"AND users.PhoneNumber LIKE :PhoneNumber",
                "paramSearch"=>array(
                    'PhoneNumber'=>$itemSearch,
                    'subscriber' => Auth::user()->subscriber
                ),
                "groupByLimit"=>"GROUP BY shippings.id LIMIT 10"

               ),

               "drivertel"=>array(
                "DownQuerySearch"=>"AND shippings.driverTel LIKE :driverTel",
                "paramSearch"=>array(
                    'driverTel'=>$itemSearch,
                    'subscriber' => Auth::user()->subscriber
                ),
                "groupByLimit"=>"GROUP BY shippings.id LIMIT 10"

               ),
               "drivername"=>array(
                "DownQuerySearch"=>"AND shippings.driverName LIKE :driverName",
                "paramSearch"=>array(
                    'driverName'=>$itemSearch,
                    'subscriber' => Auth::user()->subscriber
                ),
                "groupByLimit"=>"GROUP BY shippings.id LIMIT 10"

               ),
               "numberplate"=>array(
                "DownQuerySearch"=>"AND shippings.numberPlate LIKE :numberPlate",
                "paramSearch"=>array(
                    'numberPlate'=>$itemSearch,
                    'subscriber' => Auth::user()->subscriber
                ),
                "groupByLimit"=>"GROUP BY shippings.id LIMIT 10"

               ),
               "livelocation"=>array(
                "DownQuerySearch"=>"AND shippings.liveLocation LIKE :liveLocation",
                "paramSearch"=>array(
                    'liveLocation'=>$itemSearch,
                    'subscriber' => Auth::user()->subscriber
                ),
                "groupByLimit"=>"GROUP BY shippings.id LIMIT 10"

               ),
            "false"=>array(
             "DownQuerySearch"=>"",
             "paramSearch"=>array(

             ),
             "groupByLimit"=>"GROUP BY orders.id ORDER BY orders.id DESC LIMIT 100"
            ),
          );
          if(property_exists($searchQuery,$searchOption))
          {
            $DownQuerySearch=$searchQuery->{$searchOption}["DownQuerySearch"];
            $paramSearch=$searchQuery->{$searchOption}["paramSearch"];
            $groupByLimitSeach=$searchQuery->{$searchOption}["groupByLimit"];
            $check = DB::select("
            SELECT
                MAX(shippings.uid) as uid,
                MAX(users.name) AS name,
                MAX(users.PhoneNumber) AS PhoneNumber,
                MAX(shippings.marks) AS marks,
                MAX(shippings.driverName) AS driverName,
                MAX(shippings.driverTel) AS driverTel,
                MAX(shippings.numberPlate) AS numberPlate,
                MAX(shippings.origin) AS origin,
                MAX(shippings.liveLocation) AS liveLocation,
                MAX(shippings.destination) AS destination,
                MAX(shippings.status) AS status,
                MAX(shippings.eta) AS eta,
                MAX(shippings.created_at) AS created_at,
                MAX(shippings.commentData) AS commentData
            FROM shippings
            INNER JOIN users ON shippings.uidUser = users.uid
            WHERE shippings.subscriber = :subscriber
            $DownQuerySearch
            $groupByLimitSeach
        ",$paramSearch);

        if($check){
            return response([
                "status"=>true,
                "result"=>$check,
                "permission"=>Auth::user()->permission??'none',


            ],200);

        }
        else{
            return response([
                "status"=>false,
                "result"=>$check,
                "permission"=>Auth::user()->permission??'none',


            ],200);
        }
          }
          else{
            return response([
                "status"=>false,
                "message"=>"this search not exist"


            ],200);
          }



    }
    public function viewAllShipping($input){
        //$phoneNumber = strtolower($input["PhoneNumber"]);

        $check = DB::select("
        SELECT
            MAX(shippings.uid) as uid,
            MAX(users.name) AS name,
            MAX(users.PhoneNumber) AS PhoneNumber,
            MAX(shippings.marks) AS marks,
            MAX(shippings.driverName) AS driverName,
            MAX(shippings.driverTel) AS driverTel,
            MAX(shippings.numberPlate) AS numberPlate,
            MAX(shippings.origin) AS origin,
            MAX(shippings.liveLocation) AS liveLocation,
            MAX(shippings.destination) AS destination,
            MAX(shippings.status) AS status,
            MAX(shippings.eta) AS eta,
            MAX(shippings.created_at) AS created_at,
            MAX(shippings.commentData) AS commentData
        FROM shippings
        INNER JOIN users ON shippings.uidUser = users.uid
        WHERE shippings.subscriber = :subscriber
        GROUP BY shippings.uidUser
        ORDER BY shippings.id DESC
    ", [
        'subscriber' => Auth::user()->subscriber
    ]);

    if($check){
        return response([
            "status"=>true,
            "result"=>$check,
            "permission"=>Auth::user()->permission??'none',


        ],200);

    }

    }

    public function ShippingCreate($input){

        $PhoneNumber=$input['PhoneNumber'];
        $check=DB::select("select uid from users where PhoneNumber=:PhoneNumber and subscriber=:subscriber",[
            "PhoneNumber"=>$PhoneNumber,
            "subscriber"=>Auth::user()->subscriber
        ]);

        if($check){
            $input["uidUser"]=$check[0]->uid;
            return $this->AddUser($input);


        }
        else{



            if(($this->createUser($input)->original["status"])){
                        $input["uidUser"]=($this->createUser($input)->original["uid"]);
                        return $this->AddUser($input);

                    }
                    else{
                        return response([
                            "status"=>false,
                            "result"=>$check,
                            "message"=>"user has not added DB"

                        ],200);
                    }


        }



    }
    public function createUser($input){
        $uid=preg_replace('/[^A-Za-z0-9-]/','',$input['name']);//generated on production
        //echo $this->today;
        $uid=$uid.""."_".date(time());
                $checkUser=DB::table("users")
                ->insert([
                    'name'=>strtolower($input['name']),

                    //'fname'=>$input['fname'],
                    //'lname'=>$input['lname'],
                    'email'=>$input['email']??'none',
                    'Ccode'=>$input['Ccode']??'none',//country code
                    'phone'=>$input['phone']??'none',
                    'PhoneNumber'=>$input['PhoneNumber'],
                    'uidCreator'=>Auth::user()->uid,

                    'subscriber'=>Auth::user()->subscriber,
                    'platform'=>env('PLATFORM4'),
                    'password' =>bcrypt("gdkgjdkg"),
                    //'passdecode' =>$input['password'],
                    'initCountry'=>$input['initCountry']??'none',
                    'country'=>$input['country']??'none',
                    "carduid"=>$input["carduid"]??'none',
                    'uid'=>$uid,
                    'created_at'=>$this->today,

                ]);
                if($checkUser){
                    return response([
                        "status" =>true,

                        "uid"=>$uid
                    ]);
                }
                else{
                    return response([
                        "status" =>false,
                    ]);
                }
    }

    public function AddUser($input){
        $uidShip="SID".""."_".Str::random(2).""."_".date(time());
        $check=DB::table("shippings")
        ->insert([
            "uid"=>$uidShip,//unique Id of That Cars
            "uidUser"=>$input["uidUser"],
            "uidCreator"=>Auth::user()->uid,
            "subscriber"=>Auth::user()->subscriber,
            "marks"=>$input["marks"],
            "driverName"=>$input["driverName"],
            "driverTel"=>$input["driverTel"],
            "numberPlate"=>$input["numberPlate"],
            "origin"=>$input["origin"],
            "destination"=>$input["destination"],
           "commentData"=>$input["commentData"]??"none",
            "created_at"=>$this->today,


        ]);
        if($check){
            return response([
                "status"=>true,
                "result"=>$check,
                "userid"=>$input["uidUser"],
                "message"=>"user has added DB"

            ],200);
        }
        else{
            return response([
                "status"=>false,
                "result"=>$check,
                "message"=>"user has not added DB"

            ],200);
        }
    }
    public function editShipping($input){
  try {
    //code...
    $check=DB::select("select name,PhoneNumber,uid from users where PhoneNumber=:PhoneNumber and subscriber=:subscriber limit 1",[
        "PhoneNumber"=>$input["PhoneNumber"],
        "subscriber"=>Auth::user()->subscriber
     ]);
     $name=strtolower($input["name"]);
     $input["uidUser"]=$check[0]->uid;
     if($check){
         if(strtolower($check[0]->name)!=$name){
             ///create backup first
             //updateShip
            $checkName=DB::update("update users set name=:name where PhoneNumber=:PhoneNumber and subscriber=:subscriber limit 1",[
                 "name"=>$input["name"],
                 "PhoneNumber"=>$input["PhoneNumber"],
                "subscriber"=>Auth::user()->subscriber
             ]);
             if($checkName){
                 $input["actionStatus"]="edit";
                 if(($this->backupShip($input)->original["status"])){
                     return $this->updateShip($input);
                 }

             }


         }
         else{
             $input["actionStatus"]="edit";
             if(($this->backupShip($input)->original["status"])){
                 $uidUser["uidUser"]=$check[0]->uid;
                 return $this->updateShip($input);
             }

         }
     }
     else{

         $input["actionStatus"]="edit";

         if(($this->backupShip($input)->original["status"]))
         {
             if(($this->createUser($input)->original["status"])){
                 $uidUser["uidUser"]=($this->createUser($input)->original["uid"]);
                 return $this->updateShip($input);
             }
         }


     }
  } catch (\Exception $e) {
    //throw $th;
    return response()->json([
        'error' => 'An error occurred',
        'errorPrint' => $e->getMessage(),
        'errorCode' => $e->getLine(),
    ], 500);
  }

    }
    public function backupShip($input){

        try {
            //code...

            $actionStatus=$input["actionStatus"];
            $actionStatus = $input["actionStatus"];
            $check = DB::insert("
                INSERT INTO ship_histories (actionStatus, uid, uidCreator, name, PhoneNumber, driverName, driverTel, numberPlate, origin, liveLocation, destination, status, eta, commentData, marks, created_at)
                SELECT
                    ? as actionStatus,
                    MAX(shippings.uid) AS uid,
                    MAX(shippings.uidCreator) AS uidCreator,
                    MAX(users.name) AS name,
                    MAX(users.PhoneNumber) AS PhoneNumber,
                    MAX(shippings.driverName) AS driverName,
                    MAX(shippings.driverTel) AS driverTel,
                    MAX(shippings.numberPlate) AS numberPlate,
                    MAX(shippings.origin) AS origin,
                    MAX(shippings.liveLocation) AS liveLocation,
                    MAX(shippings.destination) AS destination,
                    MAX(shippings.status) AS status,
                    MAX(shippings.eta) AS eta,
                    MAX(shippings.commentData) AS commentData,
                    MAX(shippings.marks) AS marks,
                    MAX(shippings.created_at) AS created_at
                FROM shippings
                INNER JOIN users ON shippings.uidUser = users.uid
                WHERE shippings.subscriber = ?
                  AND shippings.uid = ?
                GROUP BY shippings.uidUser
                ORDER BY shippings.id ASC
            ", [
                $actionStatus,
                Auth::user()->subscriber,
                $input["uid"]
            ]);

            if ($check) {
                return response([
                    "status" => true,
                ]);
            } else {
                return response([
                    "status" => false,
                    "msg" => "none"
                ]);
            }

} catch (\Exception $e) {
    //throw $th;
    return response()->json([
        'error' => 'An error occurred',
        'errorPrint' => $e->getMessage(),
        'errorCode' => $e->getLine(),
    ], 500);
}


    }
    public function updateShip($input){
        $check = DB::update("
        UPDATE shippings
        SET
            uidUser = :uidUser,
            driverName = :driverName,
            driverTel = :driverTel,
            numberPlate = :numberPlate,
            origin = :origin,
            destination = :destination,
            commentData = :commentData,
            marks = :marks,
            updated_at = :updated_at
        WHERE uid = :uid limit 1
    ", [
        'uid' => $input['uid'],
        'uidUser' => $input['uidUser'],
        'driverName' => $input['driverName'],
        'driverTel' => $input['driverTel'],
        'numberPlate' => $input['numberPlate'],
        'origin' => $input['origin'],
        'destination' => $input['destination'],
        'commentData' => $input['commentData'] ?? 'none',
        'marks' => $input['marks'],
        'updated_at' => $this->today, // Assuming you are using Carbon or similar to get the current timestamp
    ]);


    }
    public function deleteShipping($input){
        try {
            //code...
            $check=DB::delete("delete from shippings where uid=:uid and subscriber=:subscriber limit 1",[
                "uid"=>$input["uid"],
                "subscriber"=>Auth::user()->subscriber
                //"uidCreator"=>Auth::user()->uid
               ]);
               if($check){
                   $input["actionStatus"]="delete";
                   if(($this->backupShip($input)->original["status"])){
                   return response([
                       "status"=>true,


                   ],200);
               }
               }
               else{
                   return response([
                       "status"=>false,


                   ],200);
               }
        } catch (\Exception $e) {
            //throw $th;
            return response()->json([
                'error' => 'An error occurred',
                'errorPrint' => $e->getMessage(),
                'errorCode' => $e->getLine(),
            ], 500);
        }


    }

    public function editStatShip($input){
        if($input["status"]=='offloaded')
        {
            $check=DB::update("update shippings set status=:status,updated_at=:updated_at where uid=:uid and subscriber=:subscriber",[
                "uid"=>$input["uid"],
                "status"=>$input["status"],
                "subscriber"=>Auth::user()->subscriber,
               "updated_at"=>$this->today,
            ]);
            if($check){
                $checkDe=DB::table("status_tracks")
                ->insert([
                    "uid"=>$input["uid"],
                    "uidCreator"=>Auth::user()->uid,
                    "subscriber"=>Auth::user()->subscriber,
                    "status"=>$input["status"],
                    "commentData"=>$input["commentData"]??"none",
                    "created_at"=>$this->today,
                ]);
                if($checkDe){
                    return response([
                        "status"=>true,


                    ],200);

                }
            }
        }
        else{

            $checkD=DB::update("update shippings set status=:status,eta=:eta,liveLocation=:liveLocation,updated_at=:updated_at where uid=:uid and subscriber=:subscriber",[
                "uid"=>$input["uid"],
                "eta"=>$input["eta"],
                "subscriber"=>Auth::user()->subscriber,
                "liveLocation"=>$input["liveLocation"],
                "status"=>$input["status"],
               "updated_at"=>$this->today,
            ]);
            if($checkD){
                $checkDa=DB::table("status_tracks")
                ->insert([
                    "uid"=>$input["uid"],
                    "uidCreator"=>Auth::user()->uid,
                    "subscriber"=>Auth::user()->subscriber,
                    "status"=>$input["status"],
                    "liveLocation"=>$input["liveLocation"],
                    "eta"=>$input["eta"],
                    "commentData"=>$input["commentData"]??"none",
                    "created_at"=>$this->today,
                ]);
                if($checkDa){
                    return response([
                        "status"=>true,


                    ],200);

                }
            }

        }

    }




    public function trackNumber(Request $request){//search by number is client do not shows only offloaded or status none

        $phoneNumber = strtolower($request->input("PhoneNumber"));
        $checkPhone=DB::select("select PhoneNumber,subscriber from users where PhoneNumber=:PhoneNumber limit 1",[
         "PhoneNumber"=>$phoneNumber
        ]);

        if($checkPhone){

            $check = DB::select("
            SELECT
                MAX(shippings.uid) AS uid,
                MAX(users.name) AS name,
                MAX(users.PhoneNumber) AS PhoneNumber,
                MAX(shippings.driverName) AS driverName,
                MAX(shippings.driverTel) AS driverTel,
                MAX(shippings.numberPlate) AS numberPlate,
                MAX(shippings.origin) AS origin,
                MAX(shippings.liveLocation) AS liveLocation,
                MAX(shippings.destination) AS destination,
                MAX(shippings.status) AS status,
                MAX(shippings.eta) AS eta,
                MAX(shippings.commentData) AS commentData
            FROM shippings
            INNER JOIN users ON shippings.uidUser = users.uid
            WHERE shippings.subscriber = :subscriber
              AND users.PhoneNumber = :PhoneNumber
              AND (shippings.status != 'none' AND shippings.status != 'offloaded')
            GROUP BY shippings.uidUser
            ORDER BY shippings.id ASC
        ", [
            'subscriber' => $checkPhone[0]->subscriber,
            'PhoneNumber' => $phoneNumber
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
        else{
            return response([
                "status"=>false,
                "msg"=>"We do have any logistic Data for you",



            ],200);
        }



    }


}
