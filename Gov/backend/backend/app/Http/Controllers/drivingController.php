<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Http\Controllers\Auth\AuthUserRegisterController;
use DB;
use Auth;
use Illuminate\Support\Str;

class drivingController extends Controller
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

    public function pricing($input){
        $method=strtolower($input["inputAction"]);

        if (method_exists($this, $method)) {
            return $this->$method($input);
        } else {
            // Handle the case where the method doesn't exist
            return response()->json(['error' => 'Method not found'], 404);
        }

    }
    public function create_pricing($input){
        $method = request()->method();
        if (request()->isMethod('post'))
        {
            try {

        $uid=Str::random(2)."_".preg_replace('/[^A-Za-z0-9-]/','',$input['name'])."_".date(time());
        $check=DB::table("pricings")
        ->insert([
            "uid"=>$uid,
            "name"=>$input['name'],
            "price"=>$input['price'],
            "status"=>$input['status'],
            "statusLive"=>$input['statusLive'],
            "commentData"=>$input['commentData']??'none',
            "subscriber"=>Auth::user()->subscriber,
            "uidCreator"=>Auth::user()->uid,
            "created_at"=>$this->today,


        ]);
        if($check)
        {
            return response([
                "status"=>true,


            ],200);
        }
        else{
            return response([
                "status"=>false,


            ],200);
        }



        } catch (\Exception $e) {
            return response()->json([
                'error' => 'An error occurred',
                'errorPrint' => $e->getMessage(),
                'errorCode' => $e->getLine(),
            ], 500);
        }
        } else{
            return response([
                "status"=>false,
                "result"=>"Method is not allowed"

            ],401);
            //abort(405, "Whoa there! The '$method' method is not allowed. Try POST like a civilized API.");
        }
    }
    public function get_pricing($input){
        $method = request()->method();
        if (request()->isMethod('get'))
        {
            try {




        } catch (\Exception $e) {
            return response()->json([
                'error' => 'An error occurred',
                'errorPrint' => $e->getMessage(),
                'errorCode' => $e->getLine(),
            ], 500);
        }
        } else{
            return response([
                "status"=>false,
                "result"=>"Method is not allowed"

            ],401);
            //abort(405, "Whoa there! The '$method' method is not allowed. Try POST like a civilized API.");
        }
    }
    public function update_pricing($input){
        $method = request()->method();
        if (request()->isMethod('put'))
        {
            try {




        } catch (\Exception $e) {
            return response()->json([
                'error' => 'An error occurred',
                'errorPrint' => $e->getMessage(),
                'errorCode' => $e->getLine(),
            ], 500);
        }
        } else{
            return response([
                "status"=>false,
                "result"=>"Method is not allowed"

            ],401);
            //abort(405, "Whoa there! The '$method' method is not allowed. Try POST like a civilized API.");
        }
    }


    public function driving($input){
        $method=strtolower($input["inputAction"]);

        if (method_exists($this, $method)) {
            return $this->$method($input);
        } else {
            // Handle the case where the method doesn't exist
            return response()->json(['error' => 'Method not found'], 404);
        }
    }
    public function create_driving($input){
        $method = request()->method();
        if (request()->isMethod('post'))
        {
            try {
                $input["drivingNumber"]=rand(1, 100)."".date(time());
                $checkUser=DB::select("select uid from users where uid=:uid limit 1",[
                    "uid"=>$input['IdNUM']
                ]);
                if($checkUser){
                    $input['userId']=$input['IdNUM'];
                    return $this->UpdateDriving($input);
                }
                else{
                    $signup=(new AuthUserRegisterController)->userIDCreated($input);
                    $data = json_decode($signup->getContent(), true);
                    if($data["status"])//AuthUserRegisterController
                    {
                        $input['userId']=$data["userid"];
                        return $this->addDriving($input);
                    }
                    else{
                        return response([
                            "status"=>false,
                            "message"=>"Your ID not existed"


                        ],200);
                    }


                }



        } catch (\Exception $e) {
            return response()->json([
                'error' => 'An error occurred',
                'errorPrint' => $e->getMessage(),
                'errorCode' => $e->getLine(),
            ], 500);
        }
        } else{
            return response([
                "status"=>false,
                "result"=>"Method is not allowed"

            ],401);
            //abort(405, "Whoa there! The '$method' method is not allowed. Try POST like a civilized API.");
        }
    }
    public function AddDrivingCat($input){


        $check=DB::table("driving_cats")
        ->insert([
            "userId"=>$input['userId'],//indangamuntu
            "category"=>$input['category'],
            "DNO"=>$input["drivingNumber"],
            "tel"=>$input['tel'],
            "uidPrice"=>$input['uidPrice'],
            "price"=>$input['price'],
            "status"=>$input['status'],
            "statusLive"=>$input['statusLive'],
            "placeIssue"=>$input['placeIssue'],
            "commentData"=>$input['commentData']??'none',
            "subscriber"=>Auth::user()->subscriber,
            "uidCreator"=>Auth::user()->uid,
            "created_at"=>$this->today,
            "updated_at"=>$this->today,//expired


        ]);
        if($check)
        {

            return response([
                "status"=>true,


            ],200);
        }
        else{
            return response([
                "status"=>false,


            ],200);
        }

    }
    public function updateDriving($input){
        $check=DB::update("update drivings set category= CONCAT(category,:category),created_at=:created_at,updated_at=:updated_at where userId=:userId",[
            "userId"=>$input["userId"],
            "category"=>"," . $input["category"],
            "created_at"=>$this->today,
            "updated_at"=>$this->today,//expired
        ]);
        if($check)
        {
            return $this->AddDrivingCat($input);

        }
        else{
            return response([
                "status"=>false,


            ],200);
        }
    }
    public function addDriving($input){

        $uid=Str::random(2)."_".preg_replace('/[^A-Za-z0-9-]/','',$input['name'])."_".date(time());

        $check=DB::table("drivings")
        ->insert([

            "userId"=>$input['userId'],//indangamuntu
            "category"=>$input['category'],
            "DNO"=>$input["drivingNumber"],//driver NUmber

            "status"=>$input['status'],
            "statusLive"=>$input['statusLive'],

            "commentData"=>$input['commentData']??'none',
            "subscriber"=>Auth::user()->subscriber,
            "uidCreator"=>Auth::user()->uid,
            "created_at"=>$this->today,
            "updated_at"=>$this->today,//expired


        ]);
        if($check)
        {
            return $this->AddDrivingCat($input);
        }
        else{
            return response([
                "status"=>false,


            ],200);
        }
    }
    public function get_driving($input){
        $method = request()->method();
        if (request()->isMethod('get'))
        {
            try {




        } catch (\Exception $e) {
            return response()->json([
                'error' => 'An error occurred',
                'errorPrint' => $e->getMessage(),
                'errorCode' => $e->getLine(),
            ], 500);
        }
        } else{
            return response([
                "status"=>false,
                "result"=>"Method is not allowed"

            ],401);
            //abort(405, "Whoa there! The '$method' method is not allowed. Try POST like a civilized API.");
        }
    }
    public function update_driving($input){
        $method = request()->method();
        if (request()->isMethod('put'))
        {
            try {




        } catch (\Exception $e) {
            return response()->json([
                'error' => 'An error occurred',
                'errorPrint' => $e->getMessage(),
                'errorCode' => $e->getLine(),
            ], 500);
        }
        } else{
            return response([
                "status"=>false,
                "result"=>"Method is not allowed"

            ],401);
            //abort(405, "Whoa there! The '$method' method is not allowed. Try POST like a civilized API.");
        }
    }

    public function cartejaune($input){
        $method=strtolower($input["inputAction"]);

        if (method_exists($this, $method)) {
            return $this->$method($input);
        } else {
            // Handle the case where the method doesn't exist
            return response()->json(['error' => 'Method not found'], 404);
        }
    }

    public function create_cartejaune($input){
        $method = request()->method();
        if (request()->isMethod('post'))
        {
            try {

                $checkUser=DB::select("select uid from users where uid=:uid limit 1",[
                    "uid"=>$input['IdNUM']
                ]);
                if($checkUser){
                    $input['userId']=$input['IdNUM'];
                    return $this->addCarteJaune($input);
                }
                else{
                    $signup=(new AuthUserRegisterController)->userIDCreated($input);
                    $data = json_decode($signup->getContent(), true);
                    if($data["status"])//AuthUserRegisterController
                    {
                        $input['userId']=$data["userid"];
                        return $this->addCarteJaune($input);
                    }
                    else{
                        return response([
                            "status"=>false,
                            "message"=>"Your ID not existed"


                        ],200);
                    }


                }


        } catch (\Exception $e) {
            return response()->json([
                'error' => 'An error occurred',
                'errorPrint' => $e->getMessage(),
                'errorCode' => $e->getLine(),
            ], 500);
        }
        } else{
            return response([
                "status"=>false,
                "result"=>"Method is not allowed"

            ],401);
            //abort(405, "Whoa there! The '$method' method is not allowed. Try POST like a civilized API.");
        }
    }

    public function addCarteJaune($input){
        $uid=Str::random(2)."_".preg_replace('/[^A-Za-z0-9-]/','',$input['name'])."_".date(time());
        $check=DB::table("cartejaunes")
        ->insert([
            "uid"=>rand(1, 100)."".date(time()),
            "userId"=>$input['userId'],//indangamuntu
            "DNO"=>$input['DNO']??'none',//driver NUmber
            "plaque"=>$input['plaque'],//plaqueId mandatory
            "tel"=>$input['tel'],
            "uidPrice"=>$input['uidPrice'],
            "price"=>$input['price'],
            "status"=>$input['status'],
            "statusLive"=>$input['statusLive'],
            "commentData"=>$input['commentData']??'none',
            "subscriber"=>Auth::user()->subscriber,
            "uidCreator"=>Auth::user()->uid,
            "created_at"=>$this->today,
            "expired_at"=>$this->today,//expired


        ]);
        if($check)
        {
            return response([
                "status"=>true,


            ],200);
        }
        else{
            return response([
                "status"=>false,


            ],200);
        }

    }
    public function get_cartejaune($input){
        $method = request()->method();
        if (request()->isMethod('get'))
        {
            try {




        } catch (\Exception $e) {
            return response()->json([
                'error' => 'An error occurred',
                'errorPrint' => $e->getMessage(),
                'errorCode' => $e->getLine(),
            ], 500);
        }
        } else{
            return response([
                "status"=>false,
                "result"=>"Method is not allowed"

            ],401);
            //abort(405, "Whoa there! The '$method' method is not allowed. Try POST like a civilized API.");
        }
    }
    public function update_cartejaune($input){
        $method = request()->method();
        if (request()->isMethod('put'))
        {
            try {




        } catch (\Exception $e) {
            return response()->json([
                'error' => 'An error occurred',
                'errorPrint' => $e->getMessage(),
                'errorCode' => $e->getLine(),
            ], 500);
        }
        } else{
            return response([
                "status"=>false,
                "result"=>"Method is not allowed"

            ],401);
            //abort(405, "Whoa there! The '$method' method is not allowed. Try POST like a civilized API.");
        }
    }
    public function plaque($input){
        $method=strtolower($input["inputAction"]);

        if (method_exists($this, $method)) {
            return $this->$method($input);
        } else {
            // Handle the case where the method doesn't exist
            return response()->json(['error' => 'Method not found'], 404);
        }
    }
    public function create_plaque($input){
        $method = request()->method();
        if (request()->isMethod('post'))
        {
            try {


               // $uid=Str::random(2)."_".preg_replace('/[^A-Za-z0-9-]/','',$input['name'])."_".date(time());
                $check=DB::table("plaques")
                ->insert([
                   // "uid"=>$uid,
                    "userId"=>$input['userId'],//indangamuntu asign to this Plaque
                    "plaque"=>$input['plaque']."".rand(1, 100)."".date(time())."CD",//plaqueId mandatory
                    "tel"=>$input['tel'],
                    "vin"=>$input['vin'],//A unique 17-digit code identifying the specific vehicle.
                    "vMake"=>$input['vMake'],//The manufacturer (e.g., Toyota, Ford).
                    "vModel"=>$input['vModel'],//The specific model name/number (e.g., Corolla, Ranger).
                    "vYear"=>$input['vYear'],//The production year of the vehicle.
                    "vEngNumber"=>$input['vEngNumber'],//Often used to uniquely identify the engine.
                    "vFuelType"=>$input['vFuelType'],//Petrol, diesel, electric, hybrid, etc.
                    "vBodyType"=>$input['vBodyType'],//Sedan, SUV, truck, motorcycle, etc.
                    "vColor"=>$input['vColor'],//pickup,truck
                    "vClass"=>$input['vClass'],//Private, commercial, government, taxi, etc.
                    "vEngSize"=>$input['vEngSize'],//Especially for motorcycles or emission classification.

                    "uidPrice"=>$input['uidPrice'],
                    "price"=>$input['price'],
                    "status"=>$input['status'],
                    "statusLive"=>$input['statusLive'],
                    "commentData"=>$input['commentData']??'none',
                    "subscriber"=>Auth::user()->subscriber,
                    "uidCreator"=>Auth::user()->uid,
                    "created_at"=>$this->today,
                    "updated_at"=>$this->today,//expired


                ]);
                if($check)
                {
                    return response([
                        "status"=>true,


                    ],200);
                }
                else{
                    return response([
                        "status"=>false,


                    ],200);
                }

        } catch (\Exception $e) {
            return response()->json([
                'error' => 'An error occurred',
                'errorPrint' => $e->getMessage(),
                'errorCode' => $e->getLine(),
            ], 500);
        }
        } else{
            return response([
                "status"=>false,
                "result"=>"Method is not allowed"

            ],401);
            //abort(405, "Whoa there! The '$method' method is not allowed. Try POST like a civilized API.");
        }
    }
    public function get_plaque($input){
        $method = request()->method();
        if (request()->isMethod('get'))
        {
            try {




        } catch (\Exception $e) {
            return response()->json([
                'error' => 'An error occurred',
                'errorPrint' => $e->getMessage(),
                'errorCode' => $e->getLine(),
            ], 500);
        }
        } else{
            return response([
                "status"=>false,
                "result"=>"Method is not allowed"

            ],401);
            //abort(405, "Whoa there! The '$method' method is not allowed. Try POST like a civilized API.");
        }
    }
    public function update_plaque($input){
        $method = request()->method();
        if (request()->isMethod('put'))
        {
            try {




        } catch (\Exception $e) {
            return response()->json([
                'error' => 'An error occurred',
                'errorPrint' => $e->getMessage(),
                'errorCode' => $e->getLine(),
            ], 500);
        }
        } else{
            return response([
                "status"=>false,
                "result"=>"Method is not allowed"

            ],401);
            //abort(405, "Whoa there! The '$method' method is not allowed. Try POST like a civilized API.");
        }
    }

    public function ticketpricing($input){
        $method=strtolower($input["inputAction"]);

        if (method_exists($this, $method)) {
            return $this->$method($input);
        } else {
            // Handle the case where the method doesn't exist
            return response()->json(['error' => 'Method not found'], 404);
        }
    }
    public function create_ticketpricing($input){
        $method = request()->method();
        if (request()->isMethod('post'))
        {
            try {

                $uid=Str::random(2)."_".preg_replace('/[^A-Za-z0-9-]/','',$input['name'])."_".date(time());
                $check=DB::table("ticketpricings")
                ->insert([
                    "uid"=>rand(1, 100)."".date(time()),
                    "name"=>$input['name'],
                    "price"=>$input['price'],
                    "descr"=>$input['descr'],
                    "status"=>$input['status'],
                    "statusLive"=>$input['statusLive'],
                    "commentData"=>$input['commentData']??'none',
                    "subscriber"=>Auth::user()->subscriber,
                    "uidCreator"=>Auth::user()->uid,
                    "created_at"=>$this->today,


                ]);
                if($check)
                {
                    return response([
                        "status"=>true,


                    ],200);
                }
                else{
                    return response([
                        "status"=>false,


                    ],200);
                }


        } catch (\Exception $e) {
            return response()->json([
                'error' => 'An error occurred',
                'errorPrint' => $e->getMessage(),
                'errorCode' => $e->getLine(),
            ], 500);
        }
        } else{
            return response([
                "status"=>false,
                "result"=>"Method is not allowed"

            ],401);
            //abort(405, "Whoa there! The '$method' method is not allowed. Try POST like a civilized API.");
        }
    }
    public function get_ticketpricing($input){
        $method = request()->method();
        if (request()->isMethod('get'))
        {
            try {




        } catch (\Exception $e) {
            return response()->json([
                'error' => 'An error occurred',
                'errorPrint' => $e->getMessage(),
                'errorCode' => $e->getLine(),
            ], 500);
        }
        } else{
            return response([
                "status"=>false,
                "result"=>"Method is not allowed"

            ],401);
            //abort(405, "Whoa there! The '$method' method is not allowed. Try POST like a civilized API.");
        }
    }
    public function update_ticketpricing($input){
        $method = request()->method();
        if (request()->isMethod('put'))
        {
            try {




        } catch (\Exception $e) {
            return response()->json([
                'error' => 'An error occurred',
                'errorPrint' => $e->getMessage(),
                'errorCode' => $e->getLine(),
            ], 500);
        }
        } else{
            return response([
                "status"=>false,
                "result"=>"Method is not allowed"

            ],401);
            //abort(405, "Whoa there! The '$method' method is not allowed. Try POST like a civilized API.");
        }
    }
    public function ticketwriting($input){
        $method=strtolower($input["inputAction"]);

        if (method_exists($this, $method)) {
            return $this->$method($input);
        } else {
            // Handle the case where the method doesn't exist
            return response()->json(['error' => 'Method not found'], 404);
        }
    }
    public function create_ticketwriting($input){
        $method = request()->method();
        if (request()->isMethod('post'))
        {
            try {

               // $uid=Str::random(2)."_".preg_replace('/[^A-Za-z0-9-]/','',$input['name'])."_".date(time());

               $check=DB::table("ticketwritings")
               ->insert([
                   "uid"=>rand(1, 100)."".date(time()),
                   "userId"=>$input["userId"],///ID indangamuntu
                   "plaqueId"=>$input['plaqueId'],
                   "faultId"=>$input['faultId'],
                   "faultPrice"=>$input['faultPrice'],
                   "faultTitle"=>$input['faultTitle'],
                   "faultDescr"=>$input['faultDescr'],
                   "status"=>$input['status'],//paid or no paid
                   "statusLive"=>$input['statusLive']??"none",//paid or no paid
                   "paidType"=>$input['paidType']??"none",//cash or car or Momo
                   "commentData"=>$input['commentData']??'none',
                   "subscriber"=>Auth::user()->subscriber,
                   "uidCreator"=>Auth::user()->uid,
                   "created_at"=>$this->today,


               ]);

               if($check)
                {
                    return response([
                        "status"=>true,


                    ],200);
                }
                else{
                    return response([
                        "status"=>false,


                    ],200);
                }


        } catch (\Exception $e) {
            return response()->json([
                'error' => 'An error occurred',
                'errorPrint' => $e->getMessage(),
                'errorCode' => $e->getLine(),
            ], 500);
        }
        } else{
            return response([
                "status"=>false,
                "result"=>"Method is not allowed"

            ],401);
            //abort(405, "Whoa there! The '$method' method is not allowed. Try POST like a civilized API.");
        }
    }
    public function sync_multiticketwriting($input){//this is batch inserting from mobile to website server
        $method = request()->method();
        if (request()->isMethod('post'))
        {
            try {

               // $uid=Str::random(2)."_".preg_replace('/[^A-Za-z0-9-]/','',$input['name'])."_".date(time());

               $myDatas = $input['myData'];
               foreach ( $myDatas as &$myData) {
                   //this is to customize field bacth
                $myData["uid"]=rand(1, 100)."".date(time());
                $myData["subscriber"]=Auth::user()->subscriber;
                $myData["uidCreator"]=Auth::user()->uid;
                $myData["statusLive"]=$myData['statusLive']??"none";
                $myData["paidType"]=$myData['paidType']??"none";
                $myData["commentData"]=$myData['commentData']??'none';
                $myData['created_at']= $this->today;
                $myData['updated_at'] = $this->today;
            }

            $check=DB::table("ticketwritings")->insert($myDatas);

               if($check)
                {
                    return response([
                        "status"=>true,


                    ],200);
                }
                else{
                    return response([
                        "status"=>false,


                    ],200);
                }


        } catch (\Exception $e) {
            return response()->json([
                'error' => 'An error occurred',
                'errorPrint' => $e->getMessage(),
                'errorCode' => $e->getLine(),
            ], 500);
        }
        } else{
            return response([
                "status"=>false,
                "result"=>"Method is not allowed"

            ],401);
            //abort(405, "Whoa there! The '$method' method is not allowed. Try POST like a civilized API.");
        }
    }
    public function get_ticketwriting($input){
        $method = request()->method();
        if (request()->isMethod('get'))
        {
            try {




        } catch (\Exception $e) {
            return response()->json([
                'error' => 'An error occurred',
                'errorPrint' => $e->getMessage(),
                'errorCode' => $e->getLine(),
            ], 500);
        }
        } else{
            return response([
                "status"=>false,
                "result"=>"Method is not allowed"

            ],401);
            //abort(405, "Whoa there! The '$method' method is not allowed. Try POST like a civilized API.");
        }
    }
    public function update_ticketwriting($input){
        $method = request()->method();
        if (request()->isMethod('put'))
        {
            try {




        } catch (\Exception $e) {
            return response()->json([
                'error' => 'An error occurred',
                'errorPrint' => $e->getMessage(),
                'errorCode' => $e->getLine(),
            ], 500);
        }
        } else{
            return response([
                "status"=>false,
                "result"=>"Method is not allowed"

            ],401);
            //abort(405, "Whoa there! The '$method' method is not allowed. Try POST like a civilized API.");
        }
    }

}

