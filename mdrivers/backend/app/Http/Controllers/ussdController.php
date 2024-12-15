<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Str;
use DB;
use Auth;


class ussdController extends Controller
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
    public function DataUssD(Request $request)
    {
        $sessionId=$request->input("sessionId");
        $serviceCode=$request->input("serviceCode");
        $phoneNumber=$request->input("phoneNumber");
        $text=$request->input("text");


        if ($text == "") {
            // This is the first request. Note how we start the response with CON


            DB::statement('INSERT INTO temp_users (uid, sessionKey) VALUES (?, ?) ON DUPLICATE KEY UPDATE sessionKey = ?', [$phoneNumber, "0", "0"]);

            $check=DB::select("select *from locations");
            $response  = "CON Booking Imodoka \n";
           /* $response .= "1. My Account \n";
            $response .= "2. My phone number";*/
            $num1=0;
            for($i=0;$i<count($check);$i++){
                $num1=$i+1;
                $num=$i+1;
                $place=$check[$i]->origin."-".$check[$i]->destination."FRW".$check[$i]->price;
                $response .=$check[$i]->id.".".$place."\n";
            }
            $num1=$num1+1;
            $response.= $num1.".Exit";

        }
        else{

            $checkUser=DB::select("select *from temp_users where uid=:uid limit 1",[
             "uid"=>$phoneNumber
            ]);
            if($checkUser[0]->sessionKey==='0'){

                $checkID=DB::select("select uid,origin,destination,commentData from locations where id=:id limit 1",[
                    "id"=>$text
                 ]);
                 if($checkID)
                 {

                     DB::update("update temp_users set sessionKey=:sessionKey,location=:location where uid=:uid limit 1",[
                         "location"=>$checkID[0]->uid,
                         "sessionKey"=>"1",
                         "uid"=>$phoneNumber,
                     ]);
                     $check=DB::select("select  id,dateOn from dashtrips where location=:location and visibleStatus=:visibleStatus limit 5",[
                         "location"=>$checkID[0]->uid,
                         "visibleStatus"=>"On"
                     ]);
                     $place=$checkID[0]->origin."-".$checkID[0]->destination;
                     $response  = "CON IZIGENDA $place \n";
                    /* $response .= "1. My Account \n";
                     $response .= "2. My phone number";*/
                     $num1=0;
                     for($i=0;$i<count($check);$i++){
                         $num1=$i+1;
                         $num=$i+1;
                         $response .=$check[$i]->id.")".$check[$i]->dateOn."\n";
                     }
                     $num1=$num1+1;
                     $response.= $num1.".Exit";
                 }
            }
            else if($checkUser[0]->sessionKey==='1')
            {
                $check=DB::select("select dateOn from dashtrips where id=:id limit 1",[
                    "id"=>$text,

                ]);
                if($check){
                    $checkSeat=DB::select("select *from client_orders where location=:location and dateOn=:dateOn limit 5",[
                        "location"=>$checkUser[0]->location,
                        "dateOn"=>$check[0]->dateOn
                    ]);
                    DB::update("update temp_users set sessionKey=:sessionKey where uid=:uid limit 1",[
                        //"location"=>$checkID[0]->uid,
                        "sessionKey"=>"2",
                        "uid"=>$phoneNumber,
                    ]);

                $dateOn=$check[0]->dateOn;
                $response  = "CON HITAMO UMWANYA $dateOn \n";
               /* $response .= "1. My Account \n";
                $response .= "2. My phone number";*/
                $num1=0;
                for($i=0;$i<count($checkSeat);$i++){
                    $num1=$i+1;
                    $num=$i+1;
                    $response .=$checkSeat[$i]->id.") Intebe ".$checkSeat[$i]->sessionKey."\n";
                }
                $num1=$num1+1;
                $response.= "0.Next";
                $response.= $num1.".Exit";
                }

            }
            else if($checkUser[0]->sessionKey==='2')
            {
                $check=DB::select("select *from client_orders where id=:id",[
                    "id"=>$text
                ]);
                 $place=$check[0]->sessionKey;
                $response  = "CON UhiseMo $place Wishyure Ukoresheje \n";
                $response  .= "1.Momo \n";

                 $response.="2.Exit";


            }
            else{

            }


        }

        // Echo the response back to the API
        header('Content-type: text/plain');
        echo $response;

    }
}
