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
                    'seatAv'=>$input['seatAv'],
                    'seatCount'=>$input['seatCount']??'none',
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

            for($i=0;$i<$input['seatAv'];$i++){
                DB::table("client_orders")
                ->insert([
                    'uid'=>$uid,
                    'dateOn'=>$input['dateOn'],//izahagurukira
                    'location'=>$input['location'],
                    "sessionKey"=>$i+1,//seat
                    "uidCreator"=>Auth::user()->uid,
                    "subscriber"=>Auth::user()->subscriber,
                ]);
            }
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
