<?php

namespace App\Http\Controllers\auth;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Auth;
use DB;

class AuthAdminLoginController extends Controller
{

    public function __construct()
    {
        date_default_timezone_set(env('TIME_ZONE'));
        $this->today = date('Y-m-d H:i:s', time());
        $this->Appstate=env('APP_LIVE')?env('APP_PRO'):env('APP_DEV');
        $this->AppName=env('APP_NAME');

        $this->otp='1 hours';
      // $this->otp='20 seconds';//test purpose
        $this->email_confirm='24 hours';

    }
    //
    public function AdminLoginEmail($input){
        if(Auth::guard('Admin')->attempt([

			'email'=>$input['email'], //means if it check username table =to input name them add input name;
			'password'=>$input['password'],


		]))

		{
            $user=auth::guard('Admin')->user();
            $success['token']=$user->createToken('MyApp')->plainTextToken;
            $success['name']=$user->email;

            return response([
                "status"=>true,
               // "result"=>Auth::guard('Admin')->user(),
                "token"=>$success['token'],
                "User"=>[
                    "uid"=>Auth::guard('Admin')->user()->uid,
                    "first_name"=>Auth::guard('Admin')->user()->fname,
                    "last_name"=>Auth::guard('Admin')->user()->name,
                    "name"=>Auth::guard('Admin')->user()->name,
                    "email"=>Auth::guard('Admin')->user()->email,
                    "tel"=>Auth::guard('Admin')->user()->phone,
                    "Ccode"=>Auth::guard('Admin')->user()->Ccode,
                    "status"=>Auth::guard('Admin')->user()->status,
                    "platform"=>Auth::guard('Admin')->user()->platform,
                    "CompanyName"=>Auth::guard('Admin')->user()->CompanyName,
                    "subscriber"=>Auth::guard('Admin')->user()->subscriber,
                ]

            ],200);

		}
        else  if(Auth::guard('Admin')->attempt([

			'PhoneNumber'=>$input['email'], //means if it check username table =to input name them add input name;
			'password'=>$input['password'],


		]))
        {

            $user=auth::guard('Admin')->user();
            $success['token']=$user->createToken('MyApp')->plainTextToken;
            $success['name']=$user->email;

            return response([
                "status"=>true,
               // "result"=>Auth::guard('Admin')->user(),
                "token"=>$success['token'],
                "User"=>[
                    "uid"=>Auth::guard('Admin')->user()->uid,
                    "first_name"=>Auth::guard('Admin')->user()->fname,
                    "last_name"=>Auth::guard('Admin')->user()->name,
                    "name"=>Auth::guard('Admin')->user()->name,
                    "email"=>Auth::guard('Admin')->user()->email,
                    "tel"=>Auth::guard('Admin')->user()->phone,
                    "Ccode"=>Auth::guard('Admin')->user()->Ccode,
                    "status"=>Auth::guard('Admin')->user()->status,
                    "platform"=>Auth::guard('Admin')->user()->platform,
                    "CompanyName"=>Auth::guard('Admin')->user()->CompanyName,
                    "subscriber"=>Auth::guard('Admin')->user()->subscriber,
                ]

            ],200);

        }

	else{
        return response([
            "status"=>false,


        ],200);

    }
    }
    public function AdminLoginPhone($input){

        if(Auth::guard('Admin')->attempt([

			'PhoneNumber'=>$input['PhoneNumber'], //means if it check username table =to input name them add input name;
			'password'=>$input['password'],


		]))

		{
            $user=auth::guard('Admin')->user();
            $success['token']=$user->createToken('MyApp')->plainTextToken;
            $success['name']=$user->email;

            return response([
                "status"=>true,
               // "result"=>Auth::guard('Admin')->user(),
                "token"=>$success['token'],
                "User"=>[
                    "uid"=>Auth::guard('Admin')->user()->uid,
                    "first_name"=>Auth::guard('Admin')->user()->fname,
                    "last_name"=>Auth::guard('Admin')->user()->name,
                    "name"=>Auth::guard('Admin')->user()->name,
                    "email"=>Auth::guard('Admin')->user()->email,
                    "tel"=>Auth::guard('Admin')->user()->phone,
                    "status"=>Auth::guard('Admin')->user()->status,
                    "Ccode"=>Auth::guard('Admin')->user()->Ccode,
                    "platform"=>Auth::guard('Admin')->user()->platform,
                    "CompanyName"=>Auth::guard('Admin')->user()->CompanyName,
                    "subscriber"=>Auth::guard('Admin')->user()->subscriber,
                ]

            ],200);

		}

	else{
        return response([
            "status"=>false,


        ],200);

    }

    }
    public function Reset_with_email($input){

    }
    public function Reset_with_phone($input){

    }

}
