<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;
use Auth;
use Illuminate\Support\Str;

class appointmentController extends Controller
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

    public function service($input){
        $actionStatus=strtolower($input['actionStatus']);
        if($actionStatus==='createService')
        {
         return $this->createService($request);
        }
        else if($actionStatus==='editService')
        {
            return $this->editService($request);
        }
        else if($actionStatus==='deleteService')
        {
       return $this->deleteService($request);
        }
        else{
            return response([
                "status"=>false,
                "message"=>"actions Status unavailable"



            ],403);
        }

    }

    public function createService($input){
        $checkOptionKey=DB::select("select uid,count(codeb) as optionCounter from services where uid=:uid limit 1",[
            "uid"=>$input['uid']??'none'
        ]);
        $uid=preg_replace('/[^A-Za-z0-9-]/');//generated on production
        //echo $this->today;
        $uid=$uid.""."_".date(time());
        $optionKey=($checkOptionKey)?($checkOptionKey[0]->optionCounter)+1:0;
        $uid=($optionKey==0)?$uid:$input['uid'];

        if($optionKey!=0)
        {
            $input['optionKey']=$optionKey;

                return $this->createServe($input);

        }else{

            $input['uid']=$uid;
            $input['optionKey']=1;
            return $this->createServe($input);
        }
    }
    public function createServe($input){
        $check=DB::table("appointments")
        ->insert([
            "uid"=>$input['uid'],
            "codeb"=>$input['codeb'],//codeb is equal to ID of code_creators//depricated is equal to uid
            "name"=>$input['name'],
            "serviceType"=>$input['serviceType'],//menu,survey,game
            "optionKey"=>$input['optionKey'],//that will be used on USSD key
            "status"=>'open',//open,close,testing,preview
            'commentData'=>$input["CommentData"]??'none',
            "uidCreator"=>Auth::user()->uid,
            "subscriber"=>Auth::user()->subscriber,

            "created_at"=>$this->today



        ]);
        if($check){
            return response([
                "status" =>true,

                "uid"=>$input['uid']
            ]);
        }
        else{
            return response([
                "status" =>false,
                "uid"=>false,
            ]);
        }
    }
    public function editService($input){

    }
    public function deleteService($input){

    }
    public function code($input){
        $actionStatus=strtolower($input['actionStatus']);
        if($actionStatus==='createcode')
        {
         return $this->createCode($request);
        }
        else if($actionStatus==='editcode')
        {
            return $this->editCode($request);
        }
        else if($actionStatus==='deletecode')
        {
       return $this->deleteCode($request);
        }
        else{
            return response([
                "status"=>false,
                "message"=>"actions Status unavailable"



            ],403);
        }


    }
    public function loadCode($input){
        $check=DB::select("select *from code_creators where uidCreator=:uidCreator",[
            "uidCreator"=>$input["uidCreator"]

        ]);

        if($check){
            return response([
                "status" =>true,


            ]);
        }
        else{
            return response([
                "status" =>false,

            ]);
        }
    }
    public function getCode($input){//getCode to check if user have temp code or
        if(Auth::user()->code>0){
        //then load all code,
       // $input["code_status"]="mine";
        $input["uidCreator"]=Auth::user()->uid;
        return $this->loadCode($input);

        }
        else{
            $numbers = [9,99,999,999,9999,99999];

$randomNumber = $numbers[array_rand($numbers)];
/*echo $randomNumber;
echo"\n";*/
$randomUnique = mt_rand(0,$randomNumber);

// Display the random number

            $input["code"]=$randomUnique;
            $input['code_status']="temporary";

            if($this->checkCode($input)){
                return $this->createCode($input);
            }
        }

    }
    public function checkCode($input){
        return DB::select("select code_creators where uid!=:uid",[
            "uid"=>$input["code"]
        ]);
    }
    public function createCode($input){


        $check=DB::table("code_creators")
        ->insert([
            "uid"=>$input['code'],//must be number
            "uidCreator"=>Auth::user()->uid,
            "code_name"=>$input["code_name"]??'none',
            "code_status"=>$input["code_status"]??'temporary',
            'status'=>$input["status"],//by default guest,own code,
            "subscriber"=>Auth::user()->subscriber,
            'commentData'=>$input["CommentData"]??'none',
            "created_at"=>$this->today

       ]);
        if($check){

            DB::update("update admins set code=code+1 where uid=:uid limit 1",[
                "uid"=>Auth::user()->uid
            ]);
            return response([
                "status" =>true,

                "uid"=>$input['code']
            ]);
        }
        else{
            return response([
                "status" =>false,
                "uid"=>$input['code'],
            ]);
        }
    }

    public function EditCode($input){

    }
    public function deleteCode($input){

    }
    public function searchCode($input)
    {

    }
    public function appointment($input){//on display
        $actionStatus=strtolower($input['actionStatus']);
        if($actionStatus==='createappointment')
        {
         return $this->createAppointment($input);
        }
        else if($actionStatus==='editappointment')
        {
            return $this->editAppointment($input);
        }
        else if($actionStatus==='EditAppointmentStatus')
        {
            return $this->EditAppointmentStatus($input);
        }
        else if($actionStatus==='deleteappointment')
        {
       return $this->deleteAppointment($input);
        }
        else{
            return response([
                "status"=>false,
                "message"=>"actions Status unavailable"



            ],403);
        }
    }
    public function createAppointment($input){//on display



        $checkOptionKey=DB::select("select uid,count(codeb) as optionCounter from appointments where uid=:uid limit 1",[
            "uid"=>$input['uid']??'none'
        ]);
        $uid=preg_replace('/[^A-Za-z0-9-]/');//generated on production
        //echo $this->today;
        $uid=$uid.""."_".date(time());
        $optionKey=($checkOptionKey)?($checkOptionKey[0]->optionCounter)+1:0;
        $uid=($optionKey==0)?$uid:$input['uid'];


        if($optionKey!=0)
        {
            $input['optionKey']=$optionKey;
            if($this->checkCreateDate($input)){
                return response([
                    "status" =>false,
                    "message"=>"this date is taken please try new one",
                ]);
            }
            else{
                return $this->createAppoint($input);
            }
        }else{

            $input['uid']=$uid;
            $input['optionKey']=1;
            return $this->createAppoint($input);
        }


    }
    public function createAppoint($input){
        $check=DB::table("appointments")
            ->insert([
                "uid"=>$input['uid'],
                "codeb"=>$input['codeb'],//codeb is equal to ID of code_creators//depricated is equal to uid
                "name"=>$input['name'],
                "limitb"=>$input['limitb'], //number of people in the meeting to participate
                "limitJson"=>json_encode(range(1, $input['limitb'])),
                "startDate"=>$input['startDate'],
                "endDate"=>$input['endDate'],
                "optionKey"=>$input['optionKey'],//that will be used on USSD key
                "status"=>'open',//open,close,testing,preview
                'commentData'=>$input["CommentData"]??'none',
                "uidCreator"=>Auth::user()->uid,
                "subscriber"=>Auth::user()->subscriber,

                "created_at"=>$this->today



            ]);
            if($check){
                return response([
                    "status" =>true,

                    "uid"=>$input['uid']
                ]);
            }
            else{
                return response([
                    "status" =>false,
                    "uid"=>false,
                ]);
            }
    }
    public function checkCreateDate($input){
        return DB::select("SELECT *
        FROM appointments
        WHERE codeb=:codeb and uid=:uid AND (endDate>:=newStartDateTime AND  startDate<=:newEndDateTime)",[
            "uid"=>$uid,
            "codeb"=>$input['codeb'],
            "newStartDateTime"=>$input["startDate"],
            "newEndDateTime"=>$input["endDate"]
        ]);
    }
    public function EditAppointmentStatus($input){
        $check=DB::update("update appointments set status=:status where uid=:uid and uidCreator=:uidCreator ",[
            "status"=>$input['status'],
            "uid"=>$input["uid"],
            "uidCreator"=>$input["uidCreator"]
        ]);
        if($check){
            return response([
                "status" =>true,

                "uid"=>$input['uid']
            ]);
        }
        else{
            return response([
                "status" =>false,
                "uid"=>false,
            ]);
        }
    }
    public function editAppointment($input){//on display

    }

    public function deleteAppointment($input){//on display

    }


    public function chooseOption($input){

        //DB::select("select")

        try {
            //code...

           $checkAppointment=DB::select("SELECT uid,codeb,limitb,limitCounter,uidCreator,startDate,endDate, JSON_EXTRACT(limitJson, CONCAT('$[', FLOOR(JSON_LENGTH(limitJson) * RAND()), ']')) AS random_value
           FROM appointments
           WHERE codeb=:codeb and status=:status and optionKey =:optionKey",[
            "codeb"=>$checkTemUser[0]->codeb,
            "status"=>"open",
            "optionKey"=>$text
           ]);
           $limitUid=$checkAppointment[0]->uid."_".$checkAppointment[0]->random_value;
            DB::table("client_applications")
         ->insert([
            "uid"=>$checkAppointment[0]->uid,
            "limitUid"=>$limitUid, //this must be unique
           /* "phone"=>$input['phone'],
            "name"=>$input['name'],*/
            "codeb"=>$checkAppointment[0]->codeb,
            "startDate"=>$checkAppointment[0]->startDate,
            "endDate"=>$checkAppointment[0]->endDate,
            "uidCreator"=>$checkAppointment[0]->uidCreator,


            "subscriber"=>Auth::user()->subscriber,
            "created_at"=>$this->today
         ]);

DB::update("UPDATE appointments
SET
status = CASE
    WHEN limitb = limitCounter + 1 THEN 'close'
    ELSE status
END,

limitCounter = limitCounter + 1,
    jsonData = JSON_REMOVE(
        jsonData,
        REPLACE(
            JSON_UNQUOTE(JSON_SEARCH(jsonData, 'one', 4)),
            '.',
            '->'
        )
    )

WHERE uid =:uid and optionKey=:optionKey limit 1",[
  "uid"=>$checkAppointment[0]->uid,
  "optionKey"=>$text

]);
        } catch (\Illuminate\Database\QueryException $e) {
            //throw $th;

            if ($e->getCode() === '23000') { // 23000 is the SQLSTATE code for unique constraint violations

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
    public function displayAppointment($input){//
       $check=DB::select("select *from appointments where uidCreator=:uidCreator ORDER BY id DESC",[
        "uidCreator"=>Auth::user()->uid
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
            "uid"=>false,
        ]);
    }
    }

    public function applicationAppointment($input){//check application on this application
        $check=DB::select("select *from client_applications where uid=:uid and uidCreator=:uidCreator order by id Desc",[
          "uid"=>$input["uid"],
          "uidCreator"=>Auth::user()->uid
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
                "uid"=>false,
            ]);
        }

    }

}
