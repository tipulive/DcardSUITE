<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;
use Auth;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Cache;

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

    public function ussdView(Request $request){
        $sessionId=$request->input("sessionId");
        $serviceCode=$request->input("serviceCode");
        $phoneNumber=$request->input("phoneNumber");
        $text=$request->input("text");

        //Cache::forget($sessionId);
        /*Cache::put($stockTempInterest,$data1,now()->addMinutes(60));
        Cache::forget($stockTempInterest);*/
        if(Cache::get($sessionId))
        {
            //Cache::forget($sessionId);
           // return $this->chooseOption($request);
           /* Cache::forget($sessionId);
            $counterLoop=0;
            return $this->menuStart($request,$counterLoop);*/
           // $counterLoop=2;
            //return $this->menuStart($request,$counterLoop);

            if(($text>0) && ((Cache::get($sessionId)[0]["next"])>=($text+1)) )
            {
                //echo "chooseOption";
                return $this->chooseOption($request);
               /* return response([
                    //"test"=>Cache::get($sessionId)[0]["mapId"][0],
                    //"num"=>$textNum,

                    "status"=>Cache::get($sessionId),





                ],200);*/
            }
            else{//then next or back or exit
                $textNum=$text - 1;
                if($text==0)
                {



                    $input["textData"]=Cache::get($sessionId)[0]["uidCode"];
                    Cache::forget($sessionId);

                    // $request->input('textData', Cache::get($sessionId)[0]["uidCode"]);
                     $request->merge($input);
                     $counterLoop=0;
                     return $this->menuStart($request,$counterLoop);

                }else if(isset(Cache::get($sessionId)[0]["mapId"][$textNum])){
                    //echo "nothing";
                    return $this->chooseOption($request);
                }
                else{
                    $counterLoop=0;
           return $this->menuStart($request,$counterLoop);
                }


                }





        }
        else{
            $counterLoop=0;
           return $this->menuStart($request,$counterLoop);

        }




    }

    public function menuStart(Request $request,$counterLoop){
        $sessionId=$request->input("sessionId");
        $serviceCode=$request->input("serviceCode");
        $phoneNumber=$request->input("phoneNumber");
        $text=($request->input("textData"))??$request->input("text");
        $response="";


        $check = DB::select("
        SELECT
            MAX(code_creators.status) AS statusOn,
            MAX(code_creators.onlineStatus) AS onlineStatus,
            MAX(code_creators.code_name) AS code_name,

            MAX(assign_services.id) AS id,
            MAX(assign_services.uid) AS uid,
            MAX(assign_services.uidCode) AS uidCode,
            MAX(assign_services.status) AS statusService,
            MAX(services.serviceType) AS serviceId,
            MAX(services.name) AS name

        FROM assign_services
        INNER JOIN code_creators ON assign_services.uidCode = code_creators.uidCode
        INNER JOIN services ON assign_services.uid = services.uid
        WHERE code_creators.uidCode = :uidCode and assign_services.id>:counterLoop
        GROUP BY assign_services.id limit 20



    ", [
        "uidCode" => $text,
        "counterLoop"=>$counterLoop
    ]);

    if($check){
        $checkOnline=($check[0]->onlineStatus==='off')?'Offline':'Online';
        $response  = "CON We are $checkOnline \n";
        $response  .= "CON choose Services \n";


        $data1[]=[
            'session_id' =>"hello",
             'uidCode' =>"done",
             'serviceCode' =>"done",
             'serviceId' =>"readOnly",
             'mappingNo'=>5,
             "mapId"=>"1,2,3",
             "name"=>"",
             "rewards"=>0,
             "point"=>0,
             "menuState"=>0,
             //"OwnerStatus"=>0,
             "next"=>0


            // Add more rows here if needed
        ];


         $mapId[]=[];//serviceUid
         $serviceArr[]=[];
         $nameArr[]=[];
          $num1=$counterLoop;
            for($i=0;$i<count($check);$i++){
                $num1=$i+1+$counterLoop;
                $num=$i+1+$counterLoop;
                $mapId[$i]=$check[$i]->uid;
                $nameArr[$i]=$check[$i]->name;
                $serviceArr[$i]=$check[$i]->serviceId;

                $response .=$num.")".$check[$i]->name."\n";
            }

            $next=$num1+1;
            $back=$num1+2;
            //$exit=$num1+3;
            $exit=0;
            $data1[0]["uidCode"]=$text;
            //$data1[0]["OwnerStatus"]=$check[0]->statusOn;
            $data1[0]["mapId"]=$mapId;
            $data1[0]["mappingNo"]=count($check);
            $data1[0]["serviceId"]=$serviceArr;
            $data1[0]["name"]=$nameArr;
            $data1[0]["next"]=$next;
            //$data1[0]["uidCode"]=$check[0]["uidCode"];

            Cache::put($sessionId,$data1,now()->addMinutes(60));

            $response.= $next.".next"."\n";
            //if($counterLoop==0) return $response;
            $response.=($counterLoop==0)?"": $back.".back"."\n";
            $response.=($counterLoop==0)?"": $exit.".exit";

            header('Content-type: text/plain');
            echo $response;
    }
    else{

        if(Cache::get($sessionId))
        {
            $input["textData"]=Cache::get($sessionId)[0]["uidCode"];
            // $request->input('textData', Cache::get($sessionId)[0]["uidCode"]);
             $request->merge($input);
             $counterLoop=0;
             return $this->menuStart($request,$counterLoop);
        }
        else{
            echo "no Data found";
        }

         //Cache::forget($sessionId);


    }




    }

    public function chooseOption(Request $request){
       // $sessionId=$request->input("sessionId");
        $text=$request->input("text");
        $textNum=$text - 1;
        $sessionId=$request->input("sessionId");

        $service=Cache::get($sessionId);
        $service[0]["serUid"]=Cache::get($sessionId)[0]["mapId"][$textNum];

        $service[0]["serName"]=Cache::get($sessionId)[0]["name"][$textNum];

        Cache::put($sessionId,$service,now()->addMinutes(10));
        $Method=Cache::get($sessionId)[0]["serviceId"][$textNum];//dynamic function or method
        return $this->$Method($request);
        /*return response([

            //"textM"=>Cache::get($sessionId)[0]["mapId"][$textNum],
            "status"=>Cache::get($sessionId),





        ],200);*/

    }
      /*Service Type FUnction Plugin to display your USSD */
/* Appointment Service Pluggin */
public function dispAppoint($request){
    $text=$request->input("text");
    //$text-1;
    $textNum=$text-1;
    $sessionId=$request->input("sessionId");
    $limitPage=2;


      if(Cache::get($sessionId)[0]["menuState"]===0){//no selected anything
        $pageNumber=0;

        return $this->displayAppointFunct($request,$limitPage,$pageNumber);

    }
    else if((Cache::get($sessionId)[0]["menuState"]>0)){
        if((Cache::get($sessionId)[0]["name"][$textNum]=="next")||(Cache::get($sessionId)[0]["name"][$textNum]=="back"))
        {

          $pageNumber=(Cache::get($sessionId)[0]["name"][$textNum]=="next")?((Cache::get($sessionId)[0]["paginate"])+1):(((Cache::get($sessionId)[0]["paginate"])!=0)?((Cache::get($sessionId)[0]["paginate"])-1):0);

          return $this->displayAppointFunct($request,$limitPage,$pageNumber);
        }else{

         //send request in case input is available//
        }
    }
    else{
        $pageNumber=0;
        return $this->displayAppointFunct($request,$limitPage,$pageNumber);

    }
}
public function displayAppointFunct($request,$limitPage,$pageNumber){
    $text=$request->input("text");
    //$text-1;
    $textNum=$text-1;
    $sessionId=$request->input("sessionId");

   $check=DB::select("SELECT *
    FROM appointments where serviceUid=:serviceUid and uidCode=:uidCode and status=:status

    LIMIT :limitPage offset :pageNumber
    ",[
        "serviceUid"=>Cache::get($sessionId)[0]["serUid"],
        "uidCode"=>Cache::get($sessionId)[0]["uidCode"],
        "limitPage"=>$limitPage,
        "pageNumber"=>$pageNumber,


        "status"=>"open"
    ]);


    if($check){
        $serviceName=($pageNumber==0)?Cache::get($sessionId)[0]["serName"]:Cache::get($sessionId)[0]["serTitle"];

        $response  = "CON $serviceName Service \n";
        $rand=rand(0,count($check)-1);
        $randN=$rand;
        $nameLabel=$check[$randN]->name;
        $replyLabel=$check[$randN]->reply;
        $rewardPoint=$check[$randN]->rewards;



       $mapId[]=[];
       $serviceArr[]=[];
       $name[]=[];
       $questions[]=[];
       $replyQ[]=[];
       $rewards[]=[];
        $num1=0;
          for($i=0;$i<count($check);$i++){
              $num1=$i+1;
              $num=$i+1;
              $mapId[$i]=$check[$i]->serviceUid;
              $mapId[$i+1]=$check[0]->serviceUid;
              $mapId[$i+2]=$check[0]->serviceUid;
              $serviceArr[$i]="dispAppoint";//to make sure this function will continue to call again and again
              $serviceArr[$i+1]="dispAppoint";
              $serviceArr[$i+2]="dispAppoint";
              $rewards[$i]=$check[$i]->rewards;
              $questions[$i]=$check[$i]->name;
              $replyQ[$i]=$check[$i]->reply;
              $replyQ[$i+1]="next";
              $replyQ[$i+2]="back";
             // $name[$i]=$check[$i]->name;

              $response .=$num.")".$check[$i]->startDate."->".$check[$i]->endDate."\n";
          }
          $response .=($num+1).")Next"."\n";
          $response .=($pageNumber!=0)?($num+2).")Back"."\n":"";
          $data1=Cache::get($sessionId);

          $data1[0]["mapId"]=$mapId;




          $data1[0]["name"]=$replyQ; //reply question


          $data1[0]["replyLabel"]=$replyLabel;

          $data1[0]["serTitle"]=$serviceName;
        $data1[0]["rewards"]=$rewardPoint;
        $data1[0]["nameLabel"]=$nameLabel;
        //$data1[0]["point"]=(Cache::get($sessionId)[0]["menuState"]!=0)?($point+($questions[$textNum]===$nameLabel?$rewards[$textNum]:0)):0;
        $data1[0]["mappingNo"]=count($check);
        $data1[0]["serviceId"]=$serviceArr;
        $data1[0]["paginate"]=$pageNumber;
        $data1[0]["method"]="dispAppoint";
        $data1[0]["menuState"]=Cache::get($sessionId)[0]["menuState"]+1;

        //$data1[0]["uidCode"]=$check[0]["uidCode"];

        Cache::put($sessionId,$data1,now()->addMinutes(60));
    }else{
        $serviceName=($pageNumber==0)?Cache::get($sessionId)[0]["serName"]:Cache::get($sessionId)[0]["serTitle"];

        $response  = "CON $serviceName No Service Found \n";

        $back=count(Cache::get($sessionId)[0]["mapId"]);
        $response .=($back).")Back"."\n";
    }


    /*return response([
        "result"=>true,

        "status"=>Cache::get($sessionId),
    ],200);*/
    header('Content-type: text/plain');
  echo $response;
}
/* Appointment Service Pluggin */
      /* display Service Pluggin */
      public function dispapp($request){
        $text=$request->input("text");
        //$text-1;
        $textNum=$text-1;
        $sessionId=$request->input("sessionId");
        $limitPage=2;


          if(Cache::get($sessionId)[0]["menuState"]===0){//no selected anything
            $pageNumber=0;

            return $this->displayFunct($request,$limitPage,$pageNumber);

        }
        else if((Cache::get($sessionId)[0]["menuState"]>0)){
            if((Cache::get($sessionId)[0]["name"][$textNum]=="next")||(Cache::get($sessionId)[0]["name"][$textNum]=="back"))
            {

              $pageNumber=(Cache::get($sessionId)[0]["name"][$textNum]=="next")?((Cache::get($sessionId)[0]["paginate"])+1):(((Cache::get($sessionId)[0]["paginate"])!=0)?((Cache::get($sessionId)[0]["paginate"])-1):0);

              return $this->displayFunct($request,$limitPage,$pageNumber);
            }else{

              $pageNumber=0;
              return $this->displayFunct($request,$limitPage,$pageNumber);

            }
        }
      }
      public function displayFunct($request,$limitPage,$pageNumber){
        $text=$request->input("text");
        //$text-1;
        $textNum=$text-1;
        $sessionId=$request->input("sessionId");

       $check=DB::select("SELECT *
        FROM appointments where serviceUid=:serviceUid and uidCode=:uidCode and status=:status

        LIMIT :limitPage offset :pageNumber
        ",[
            "serviceUid"=>Cache::get($sessionId)[0]["serUid"],
            "uidCode"=>Cache::get($sessionId)[0]["uidCode"],
            "limitPage"=>$limitPage,
            "pageNumber"=>$pageNumber,


            "status"=>"open"
        ]);


        if($check){
            $serviceName=($pageNumber==0)?Cache::get($sessionId)[0]["serName"]:Cache::get($sessionId)[0]["serTitle"];

            $response  = "CON $serviceName Service \n";
            $rand=rand(0,count($check)-1);
            $randN=$rand;
            $nameLabel=$check[$randN]->name;
            $replyLabel=$check[$randN]->reply;
            $rewardPoint=$check[$randN]->rewards;



           $mapId[]=[];
           $serviceArr[]=[];
           $name[]=[];
           $questions[]=[];
           $replyQ[]=[];
           $rewards[]=[];
            $num1=0;
              for($i=0;$i<count($check);$i++){
                  $num1=$i+1;
                  $num=$i+1;
                  $mapId[$i]=$check[$i]->serviceUid;
                  $mapId[$i+1]=$check[0]->serviceUid;
                  $mapId[$i+2]=$check[0]->serviceUid;
                  $serviceArr[$i]="dispapp";//to make sure this function will continue to call again and again
                  $serviceArr[$i+1]="dispapp";
                  $serviceArr[$i+2]="dispapp";
                  $rewards[$i]=$check[$i]->rewards;
                  $questions[$i]=$check[$i]->name;
                  $replyQ[$i]=$check[$i]->reply;
                  $replyQ[$i+1]="next";
                  $replyQ[$i+2]="back";
                 // $name[$i]=$check[$i]->name;

                  $response .=$num.")".$check[$i]->name."\n";
              }
              $response .=($num+1).")Next"."\n";
              $response .=($pageNumber!=0)?($num+2).")Back"."\n":"";
              $data1=Cache::get($sessionId);

              $data1[0]["mapId"]=$mapId;




              $data1[0]["name"]=$replyQ; //reply question


              $data1[0]["replyLabel"]=$replyLabel;

              $data1[0]["serTitle"]=$serviceName;
            $data1[0]["rewards"]=$rewardPoint;
            $data1[0]["nameLabel"]=$nameLabel;
            //$data1[0]["point"]=(Cache::get($sessionId)[0]["menuState"]!=0)?($point+($questions[$textNum]===$nameLabel?$rewards[$textNum]:0)):0;
            $data1[0]["mappingNo"]=count($check);
            $data1[0]["serviceId"]=$serviceArr;
            $data1[0]["paginate"]=$pageNumber;
            $data1[0]["method"]="dispapp";
            $data1[0]["menuState"]=Cache::get($sessionId)[0]["menuState"]+1;

            //$data1[0]["uidCode"]=$check[0]["uidCode"];

            Cache::put($sessionId,$data1,now()->addMinutes(60));
        }else{
            $serviceName=($pageNumber==0)?Cache::get($sessionId)[0]["serName"]:Cache::get($sessionId)[0]["serTitle"];

            $response  = "CON $serviceName No Service Found \n";

            $back=count(Cache::get($sessionId)[0]["mapId"]);
            $response .=($back).")Back"."\n";
        }


        /*return response([
            "result"=>true,

            "status"=>Cache::get($sessionId),
        ],200);*/
        header('Content-type: text/plain');
      echo $response;
      }
      /* display Service Pluggin */
/*Job Pluggin*/
public function jobapp($request){
    $text=$request->input("text");
    //$text-1;
    $textNum=$text-1;
    $sessionId=$request->input("sessionId");


      if(Cache::get($sessionId)[0]["menuState"]===0){//no selected anything

        $check=DB::select("SELECT *
        FROM appointments where serviceUid=:serviceUid and uidCode=:uidCode and status=:status
        ORDER BY RAND()
        LIMIT 3
        ",[
            "serviceUid"=>Cache::get($sessionId)[0]["serUid"],
            "uidCode"=>Cache::get($sessionId)[0]["uidCode"],


            "status"=>"open"
        ]);


        return response([
            "result"=>true,
            "status"=>$check,
        ],200);

    }
}
/*Job Pluggin*/
      /*Game Plugin */
    public function PlayService($request){
        //
        $text=$request->input("text");
        //$text-1;
        $sessionId=$request->input("sessionId");
        //Cache::forget($sessionId);
        if((Cache::get($sessionId)[0]["menuState"])%2!=0)//choose Option
        {
           /*$data1[0]["menuState"]=Cache::get($sessionId)[0]["menuState"]+1;

           // $data1[0]["uidCode"]=$check[0]["uidCode"];

            Cache::put($sessionId,$data1,now()->addMinutes(60));*/
            return $this->DisplayPlayService($request);

            /*return response([
                //"test"=>Cache::get($sessionId)[0]["mapId"][0],
                //"num"=>$textNum,


                "test"=>"playserv",
                "serUid"=>Cache::get($sessionId)[0]["serUid"],
                "status"=>Cache::get($sessionId),





            ],200);*/


        }
        else{

            /*return response([
                //"status"=>Cache::get($sessionId)[0]["mapId"][0],


                "status"=>Cache::get($sessionId)




            ],200);*/
            return $this->DisplayPlayService($request);
        }




    }

    public function DisplayPlayService($request)
    {
        $text=$request->input("text");
        //$text-1;
        $textNum=$text-1;
        $sessionId=$request->input("sessionId");


          if(Cache::get($sessionId)[0]["menuState"]===0){//no selected anything

            $check=DB::select("SELECT *
            FROM appointments where serviceUid=:serviceUid and uidCode=:uidCode and status=:status
            ORDER BY RAND()
            LIMIT 3
            ",[
                "serviceUid"=>Cache::get($sessionId)[0]["serUid"],
                "uidCode"=>Cache::get($sessionId)[0]["uidCode"],


                "status"=>"open"
            ]);

            $serviceName=Cache::get($sessionId)[0]["serName"];
            $point=Cache::get($sessionId)[0]["point"];
            $response  = "CON $serviceName Service \n";
            $rand=rand(0,count($check)-1);
            $randN=$rand;
            $nameLabel=$check[$randN]->name;
            $replyLabel=$check[$randN]->reply;
            $rewardPoint=$check[$randN]->rewards;


            $response .= "CON  $nameLabel Points $point \n";
           $mapId[]=[];
           $serviceArr[]=[];
           $name[]=[];
           $questions[]=[];
           $replyQ[]=[];
           $rewards[]=[];
            $num1=0;
              for($i=0;$i<count($check);$i++){
                  $num1=$i+1;
                  $num=$i+1;
                  $mapId[$i]=$check[$i]->serviceUid;
                  $serviceArr[$i]="PlayService";//to make sure this function will continue to call again and again
                  $rewards[$i]=$check[$i]->rewards;
                  $questions[$i]=$check[$i]->name;
                  $replyQ[$i]=$check[$i]->reply;
                 // $name[$i]=$check[$i]->name;

                  $response .=$num.")".$check[$i]->reply."\n";
              }

              $data1=Cache::get($sessionId);

              $data1[0]["mapId"]=$mapId;
              $data1[0]["name"]=$replyQ; //reply question
              $data1[0]["replyLabel"]=$replyLabel;

              $data1[0]["pointAdded"]=$data1[0]["name"];
            $data1[0]["rewards"]=$rewardPoint;
            $data1[0]["nameLabel"]=$nameLabel;
            //$data1[0]["point"]=(Cache::get($sessionId)[0]["menuState"]!=0)?($point+($questions[$textNum]===$nameLabel?$rewards[$textNum]:0)):0;
            $data1[0]["mappingNo"]=count($check);
            $data1[0]["serviceId"]=$serviceArr;
            $data1[0]["method"]="PlayService";
            $data1[0]["menuState"]=Cache::get($sessionId)[0]["menuState"]+1;

            //$data1[0]["uidCode"]=$check[0]["uidCode"];

            Cache::put($sessionId,$data1,now()->addMinutes(60));
           /* return response([
                "result"=>true,
                "status"=>Cache::get($sessionId),
            ],200);*/
            header('Content-type: text/plain');
          echo $response;
          }
          else{
            $data1=Cache::get($sessionId);
            $point=((Cache::get($sessionId)[0]["name"][$textNum]===Cache::get($sessionId)[0]["replyLabel"])?Cache::get($sessionId)[0]["point"]+Cache::get($sessionId)[0]["rewards"]:Cache::get($sessionId)[0]["point"]+0);
            $data1[0]["point"]=$point;
            Cache::put($sessionId,$data1,now()->addMinutes(60));
            $check=DB::select("SELECT *
            FROM appointments where serviceUid=:serviceUid and uidCode=:uidCode and status=:status
            ORDER BY RAND()
            LIMIT 3
            ",[
                "serviceUid"=>Cache::get($sessionId)[0]["serUid"],
                "uidCode"=>Cache::get($sessionId)[0]["uidCode"],


                "status"=>"open"
            ]);



            $serviceName=Cache::get($sessionId)[0]["serName"];

            $response  = "CON $serviceName Service \n";
            $rand=rand(0,count($check)-1);
            $randN=$rand;
            $nameLabel=$check[$randN]->name;
            $replyLabel=$check[$randN]->reply;
            $rewardPoint=$check[$randN]->rewards;



            $response .= "CON  $nameLabel Points $point \n";
           $mapId[]=[];
           $serviceArr[]=[];
           $name[]=[];
           $questions[]=[];
           $replyQ[]=[];
           $rewards[]=[];
            $num1=0;
              for($i=0;$i<count($check);$i++){
                  $num1=$i+1;
                  $num=$i+1;
                  $mapId[$i]=$check[$i]->serviceUid;
                  $serviceArr[$i]="PlayService";//to make sure this function will continue to call again and again
                  $rewards[$i]=$check[$i]->rewards;
                  $questions[$i]=$check[$i]->name;
                  $replyQ[$i]=$check[$i]->reply;
                 // $name[$i]=$check[$i]->name;

                  $response .=$num.")".$check[$i]->reply."\n";
              }



              $data1[0]["mapId"]=$mapId;
              $data1[0]["name"]=$replyQ; //reply question
              $data1[0]["replyLabel"]=$replyLabel;

              $data1[0]["pointAdded"]=$data1[0]["name"];
            $data1[0]["rewards"]=$rewardPoint;
          $data1[0]["nameLabel"]=$nameLabel;
         // $data1[0]["point"]=(Cache::get($sessionId)[0]["menuState"]!=0)?($point+($questions[$textNum]===$nameLabel?$rewards[$textNum]:0)):0;

         $data1[0]["mappingNo"]=count($check);
          $data1[0]["serviceId"]=$serviceArr;
          $data1[0]["method"]="PlayService";
          $data1[0]["menuState"]=Cache::get($sessionId)[0]["menuState"]+1;

          //$data1[0]["uidCode"]=$check[0]["uidCode"];

          Cache::put($sessionId,$data1,now()->addMinutes(60));




         /* return response([

            "status"=>Cache::get($sessionId),
        ],200);*/
        header('Content-type: text/plain');
          echo $response;
          }


         // $pointAdded=($data1[0]["name"][$textNum]===$replyLabel)?$point+$rewardPoint:$point+0;
          //$pointAdded=$data1[0]["name"][$textNum];
          //$data1[0]["point"]=$pointAdded;

          //$response.=(Cache::get($sessionId)[0]["menuState"]!=0)?$questions[$textNum]:"none";
         // $response.= $num1.".Exit";

          /*header('Content-type: text/plain');
          echo $response;*/

// Get a random key



    }
    /*Game Plugin */
    public function TestService($request){//for sandBox Purpose
        $sessionId=$request->input("sessionId");
        //Cache::forget($sessionId);
        return response([

            "status"=>$request->input("text"),



        ],200);

    }
    public function ussdViews(Request $request){
        $sessionId=$request->input("sessionId");
        $serviceCode=$request->input("serviceCode");
        $phoneNumber=$request->input("phoneNumber");
        $text=$request->input("text");
        if ($text == "") {//Means to display Enter your Code
            $response  = "CON Search Code \n";
            $response.= "1.Exit";

        }
        else{
            $check = DB::select("
            SELECT
                MAX(code_creators.status) AS statusOn,
                MAX(code_creators.code_name) AS code_name,
                MAX(appointments.status) AS statusAppoint,
                MAX(appointments.optionKey) AS optionKey,
                MAX(appointments.startDate) AS startDate,
                MAX(appointments.endDate) AS endDate,
                MAX(appointments.name) AS name,
                MAX(appointments.limitJson) AS dataJson
            FROM appointments
            INNER JOIN code_creators ON appointments.codeb = code_creators.uid
            WHERE code_creators.uid = :uid
            GROUP BY appointments.id
        ", [
            "uid" => $text
        ]);

            $codeName=$check[0]->code_name;
            $name=$check[0]->name;
            $statusOn=$check[0]->statusOn;
            $dataJson=json_decode($check[0]->dataJson, true);
            $key = 'kinya';
            $response  = "CON $dataJson[$key] \n";
            $response  .= "CON WAHISEMO $text $codeName $statusOn \n";
            $response  .= "CON HITAMO  $name \n";
            $num1=0;
            for($i=0;$i<count($check);$i++){
                $num1=$i+1;
                $num=$i+1;
                $response .=$check[$i]->optionKey.")".$check[$i]->startDate."->".$check[$i]->endDate."\n";
            }
            $num1=$num1+1;
            $response.= "0.Next";
            $response.= $num1.".Exit";


        }


        header('Content-type: text/plain');
        echo $response;
    }
    public function displayService(){//this method will be displayed when there is more menu on service

        DB::statement('INSERT INTO temp_users (uid, sessionKey) VALUES (?, ?) ON DUPLICATE KEY UPDATE sessionKey = ?', [$phoneNumber, "0", "0"]);

        //DB::select("select ")
    }
    public function chooseLanguage($input){
        //kinyarwanda will have 1 index, 0 index is
    }
    public function service($input){
        $actionStatus=strtolower($input['actionStatus']);
        if($actionStatus=='createservice')
        {
            //echo"hello";
         return $this->createService($input);
        }
        else if($actionStatus=='getservice')
        {

          return $this->getService($input);
        }
        else if($actionStatus==='editservice')
        {
            return $this->editService($input);
        }
        else if($actionStatus==='deleteservice')
        {
       return $this->deleteService($input);
        }
        else if($actionStatus==='assignservice')
        {
       return $this->AssignService($input);
        }
        else{
            return response([
                "status"=>false,
                "message"=>"actions Status unavailable"



            ],403);
        }

    }
    public function getService($input){
      $check=DB::select("select *from services where status=:status",[
          "status"=>'open'
      ]);
      if($check){
        return response([
            "status"=>true,
            "result"=>$check



        ],200);
      }else{
        return response([
            "status"=>false,
            "result"=>$check



        ],200);
      }
    }
    public function AssignService($input){

        $checkExist=DB::select("select uid and uidCode from assign_services where uid=:uid and uidCode=:uidCode and subscriber=:subscriber",[
            "uid"=>$input["uid"],
            "uidCode"=>$input["uidCode"],
            "subscriber"=>Auth::user()->subscriber
        ]);

        if(!$checkExist)
        {
            $check=DB::table("assign_services")
            ->insert([
                "uid"=>$input["uid"],
                "uidCode"=>$input["uidCode"],
                "status"=>'open',//open,close,testing,preview
                'commentData'=>$input["commentData"]??'none',
                "uidCreator"=>Auth::user()->uid,
                "subscriber"=>Auth::user()->subscriber,

                "created_at"=>$this->today



            ]);
            if($check){
                return response([
                    "status" =>true,

                   // "uid"=>$input['uid']
                ]);
            }
            else{
                return response([
                    "status" =>false,
                    "uid"=>false,
                ]);
            }
        }else{
            $check=DB::update("update assign_services set status=:status where uid=:uid and uidCode=:uidCode and subscriber=:subscriber",[
            "status"=>"Open",
            "uid"=>$input["uid"],
            "uidCode"=>$input["uidCode"],
            "subscriber"=>Auth::user()->subscriber
            ]);
            if($check){
                return response([
                    "status" =>true,

                   // "uid"=>$input['uid']
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

    /*public function createService($input){


        $checkOptionKey = DB::select("
        SELECT id, Max(uid) as uid, COUNT(codeb) AS optionCounter
        from services
        WHERE uid = :uid
        GROUP BY id
    ", [
        'uid' => $input['uid'] ?? 'none'
    ]);

    $uid=preg_replace('/[^A-Za-z0-9-]/','',$input['name']);//generated on production
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
    }*/

    public function createService($input){

        return $this->createServe($input);
    }
    public function createServe($input){
        $uid=preg_replace('/[^A-Za-z0-9-]/','',$input['name']);//generated on production
        //echo $this->today;
        $uid=$uid.""."_".date(time());

        $check=DB::table("services")
        ->insert([
            "uid"=> $uid,
            //"codeb"=>$input['codeb'],//codeb is equal to ID of code_creators//depricated is equal to uid
            //"uidCode"=>$input['uidCode'],
            "name"=>$input['name'],
            "serviceType"=>$input['serviceType'],//menu,survey,game
            //"optionKey"=>$input['optionKey'],//that will be used on USSD key
            "status"=>'open',//open,close,testing,preview
            'commentData'=>$input["commentData"]??'none',
            "uidCreator"=>Auth::user()->uid,
            "subscriber"=>Auth::user()->subscriber,

            "created_at"=>$this->today



        ]);
        if($check){
            return response([
                "status" =>true,

               // "uid"=>$input['uid']
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
                "status" =>$check,


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


// Display the random number

             $input["code"]=$this->randomNum();

            $input['code_status']="temporary";

            if($this->checkCode($input)){

                 $input["code"]=$this->randomNum();
                return $this->createCode($input);
            }
            else{

                return $this->createCode($input);
            }

        }

    }

    public function randomNum(){
        $numbers = [9,99,999,999,9999,99999];

        $randomNumber = $numbers[array_rand($numbers)];
        /*echo $randomNumber;
        echo"\n";*/
       return mt_rand(0,$randomNumber);
    }

    public function checkCode($input){
        return DB::select("select *from code_creators  where uid!=:uid",[
            "uid"=>$input["code"]
        ]);
    }
    public function createCode($input){


        $check=DB::table("code_creators")
        ->insert([
            "uid"=>$input['code'],//must be number
            "uidCode"=>$input['code']."_".Str::random(2).""."_".date(time()),//must be number
            "uidCreator"=>Auth::user()->uid,
            "code_name"=>$input["code_name"]??'none',
            "code_status"=>$input["code_status"]??'temporary',
            'status'=>$input["status"]??'none',//by default guest,own code,
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



        $checkOptionKey = DB::select("
        SELECT id, Max(uid) as uid, COUNT(uidCode) AS optionCounter
        FROM appointments
        WHERE uid = :uid
        GROUP BY id
    ", [
        'uid' => $input['uid'] ?? 'none'
    ]);

    $uid=preg_replace('/[^A-Za-z0-9-]/','',$input['name']);//generated on production
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
                "limitUid"=>"uid"."_".Str::random(3).""."_".date(time()),
                //"codeb"=>$input['codeb'],//codeb is equal to ID of code_creators//depricated is equal to uid
                "uidCode"=>$input['uidCode'],
                "name"=>$input['name'],
                "serviceType"=>$input['serviceType'],
                "serviceUid"=>$input['serviceUid'],
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
        return DB::select("
    SELECT *
    FROM appointments
    WHERE uidCode = :uidCode
      AND uid = :uid
      AND (endDate >= :newStartDateTime AND startDate <= :newEndDateTime)
", [
    "uid" => $input['uid'],
    "uidCode" => $input['uidCode'],
    "newStartDateTime" => $input["startDate"],
    "newEndDateTime" => $input["endDate"]
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


    public function SurveyService($request){

    }
    public function gameService($request){

    }
     /*Service Type FUnction Plugin to display your USSD */
    public function chooseOptions(Request $request){// i need to add traansaction here in case one failed then rollback

        //DB::select("select")
        $text=$request->input("text");
        try {
            //code...

           $checkAppointment=DB::select("SELECT uid,uidCode,limitUid,codeb,limitb,limitCounter,uidCreator,subscriber,startDate,endDate, JSON_EXTRACT(limitJson, CONCAT('$[', FLOOR(JSON_LENGTH(limitJson) * RAND()), ']')) AS random_value
           FROM appointments
           WHERE codeb=:codeb and status=:status and optionKey =:optionKey",[
            "codeb"=>"8",//$checkTemUser[0]->codeb,
            "status"=>"open",
            "optionKey"=>$text
           ]);
           if(!$checkAppointment) return "appointment Close";
           $randomValue=$checkAppointment[0]->random_value;
           $limitUid=$checkAppointment[0]->limitUid."_".$randomValue;
            DB::table("client_applications")
         ->insert([
            "uid"=>$checkAppointment[0]->uid,
            "limitUid"=>$limitUid, //this must be unique
           /* "phone"=>$input['phone'],
            "name"=>$input['name'],*/
            "codeb"=>$checkAppointment[0]->codeb,
            "uidCode"=>$checkAppointment[0]->uidCode,
            "startDate"=>$checkAppointment[0]->startDate,
            "endDate"=>$checkAppointment[0]->endDate,
            "uidCreator"=>$checkAppointment[0]->uidCreator,


            "subscriber"=>$checkAppointment[0]->subscriber,
            "created_at"=>$this->today
         ]);

DB::update("UPDATE appointments
SET
status = CASE
    WHEN limitb = limitCounter + 1 THEN 'close'
    ELSE status
END,

limitCounter = limitCounter + 1,
  limitJson = JSON_REMOVE(
        limitJson,
        REPLACE(
            JSON_UNQUOTE(JSON_SEARCH(limitJson, 'one', $randomValue)),
            '.',
            '->'
        )
    )

WHERE uid =:uid and optionKey=:optionKey limit 1",[
  "uid"=>$checkAppointment[0]->uid,
  "optionKey"=>$text

]);
return response([
    "status" => true



]);
        } catch (\Illuminate\Database\QueryException $e) {
            //throw $th;

            if ($e->getCode() === '23000') { // 23000 is the SQLSTATE code for unique constraint violations

                return response([
                    "status" => false,
                    "errorMessage" => "This Seat number $seat is taken, please try another one.",
                    //'errorCode' => $e->getLine(),
                    //'errorPrint' => $e->getMessage(),

                ]);
            }

            // Handle other query exceptions if needed
            return response([
                "status" => false,
                "errorMessage" => "An unexpected error occurred.",
                //'errorCode' => $e->getLine(),
                //'errorPrint' => $e->getMessage(),
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
