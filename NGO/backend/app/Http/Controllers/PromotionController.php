<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;
use Auth;

class PromotionController extends Controller
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

    public function CreatePromotionEvent($input)
    {
        $uid=preg_replace('/[^A-Za-z0-9-]/','',$input['promoName']);
        $uid=$uid.""."_".date(time());
        $extension=$input["extended_date"];
           $started=explode('to',$extension)[0];
           $endto=explode('to',$extension)[1];
        $check=DB::table("promotions")
        ->insert([
         "uid"=>$uid,
         "uidCreator"=>Auth::user()->uid,
         "subscriber"=>Auth::user()->subscriber,
         "promoName"=>$input["promoName"],
         "promo_msg"=>$input["promoMsg"],
         "reach"=>$input["reach"],//number
         "gain"=>$input["gain"],//number
         "token"=>$input["token"]??'none',//token that is equal after promotion finished
         "started_date"=>$started,
         "ended_date"=>$endto,
         //"ended_date"=>(STR_TO_DATE($endto, '%Y-%m-%d %H:%i:%s')),
         "status"=>"On",
         "created_at"=>$this->today,

        ]);
        if($check)
        {

         return response([
             "status"=>true,
             "result"=>$check


         ],200);
        }
        else{
         return response([
             "status"=>false,
             "result"=>$check,

         ],200);
        }




    }


    public function EditPromotionEvent($input)
    {
        $uid=$input['uid'];
        $extension=$input["extended_date"];
           $started=explode('to',$extension)[0];
           $endto=explode('to',$extension)[1];
        $check=DB::update("update promotions set promoName=:promoName,promo_msg=:promo_msg,reach=:reach,gain=:gain,started_date=:started_date,ended_date=:ended_date,updated_at=:updated_at,status=:status where uid=:uid and subscriber=:subscriber limit 1",array(
            "uid"=>$input["uid"],
            //"uidCreator"=>Auth::user()->uid,
            "subscriber"=>Auth::user()->subscriber,
            "promoName"=>$input["promoName"],
            "promo_msg"=>$input["promoMsg"],
            "reach"=>$input["reach"],//number
            "gain"=>$input["gain"],//number
            //"token"=>$input["token"]??'none',//token that is equal after promotion finished
            "started_date"=>$started,
            "ended_date"=>$endto,
            //"ended_date"=>(STR_TO_DATE($endto, '%Y-%m-%d %H:%i:%s')),
            "status"=>"On",
            "updated_at"=>$this->today,
        ));

        if($check)
        {

         return response([
             "status"=>true,
             "result"=>$check


         ],200);
        }
        else{
         return response([
             "status"=>false,
             "result"=>$check,

         ],200);
        }




    }
    public function ViewAllPromotionEvent($input)//Get all promotion that has  On status
    {


        $check=DB::select("select *from promotions where subscriber=:subscriber limit 100",array(
            "subscriber"=>Auth::user()->subscriber
        ));
        if($check)
        {


         return response([
             "status"=>true,
             "result"=>$check,
             "datas"=>$this->today


         ],200);
        }
        else{

                return response([
                    "status"=>false,
                    "result"=>$check,

                ],200);


        }




    }
    //start here
    public function GetAllPromotionEvent($input)//Get all promotion that has  On status
    {

        $check1=DB::update("update promotions set status='close' where status='on' and subscriber=:subscriber and ended_date<='$this->today' limit 50",array(
            "subscriber"=>Auth::user()->subscriber
        ));
        $check=DB::select("select *from promotions where subscriber=:subscriber and status='On' limit 100",array(
            "subscriber"=>Auth::user()->subscriber
        ));
        if($check)
        {


         return response([
             "status"=>true,
             "result"=>$check,
             "datas"=>$this->today


         ],200);
        }
        else{

                return response([
                    "status"=>false,
                    "result"=>$check,

                ],200);


        }




    }


    public function SetPromotionEventStatus($input)//On,Off,Close //not Default status it does not need to be set on Database
    {
        $check=DB::update("update promotions set status=:status where uid=:uid and subscriber=:subscriber  limit 1",array(
            "uid"=>$input["uid"],
            "subscriber"=>Auth::user()->subscriber,
            "status"=>$input["status"]
        ));
        if($check)
        {


         return response([
             "status"=>true,
             "result"=>$check


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
