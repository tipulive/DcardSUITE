<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Http\Controllers\ParticipateController;
use DB;
use Auth;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Cache;
//Sandbox
class StockController extends Controller
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
    public function upload(Request $request)
{

    $actionStatus=$request->input("actionStatus");
    if($actionStatus==='upload')
    {
     return $this->uploadImage($request);
    }
    else if($actionStatus==='setDefault')
    {
        return $this->setDefault($request);
    }
    else if($actionStatus==='EditUpload')
    {
return $this->EditImage($request);
    }
    else{

    }

}

public function imageUpload(Request $request,$fileNumb,$isFilenameExist)
{
    $validator = Validator::make($request->all(), [
        'image' => 'required|image|mimes:jpeg,png,jpg|max:2048',
        'productCode' => 'required|string',
    ]);

    if ($validator->fails()) {
        return [
            'status' => false,
            'msg' => 'Validation failed',
            'errors' => $validator->errors()
        ];
    }

    try {
        // Define the destination path for the image
        $destinationPath = base_path('images/product');

        // Generate a unique filename for the image
        //$filename = time() . '.' . $request->file('image')->extension();

$filename = ($isFilenameExist==="true")?$fileNumb:$request->input('productCode').'_'.Auth::user()->subscriber.'_'.$fileNumb.'.' . $request->file('image')->extension();
//there $fileNumb is equal to existed filename
        // Move the image to the destination path
        $request->file('image')->move($destinationPath, $filename);

        return [
            'status' => true,
            'filename' => $filename
        ];
    } catch (\Exception $e) {
        return [
            'status' => false,
            'msg' => 'File upload error',
            'error' => $e->getMessage()
        ];
    }
}
public function uploadImage(Request $request)
{
    DB::beginTransaction();

    try {

   $input=$request->all();
        $check=DB::table('products')
            ->select('mult_imgurl')
            ->where('productCode', $input['productCode'])
            ->first();

        if ($check->mult_imgurl === 'none') {
            $uploadedFile = $this->imageUpload($request,1,"false");
            if ($uploadedFile['status']) {
                DB::update("UPDATE products SET  mult_imgurl = :mult_imgurl WHERE productCode = :productCode and subscriber=:subscriber", [
                    //'img_url' => $uploadedFile['filename'],
                    'subscriber' => Auth::user()->subscriber,
                    'mult_imgurl' => 1,
                    'productCode' => $input['productCode']
                ]);

                DB::table('product_images')->insert([
                    'productCode' => $input['productCode'],
                    'img_url' => $uploadedFile['filename'],
                    'subscriber' => Auth::user()->subscriber,
                    'created_at' => $this->today
                ]);

                DB::commit();

                return response()->json([
                    'status' => true,
                    'filename' => $uploadedFile['filename']
                ]);
            } else {
                return response()->json([
                    'status' => false,
                    'msg' => 'Image not uploaded'
                ]);
            }
        } elseif ($check->mult_imgurl + 1 >= 5) {
            // Enough pictures, three pictures only required

            return response()->json([
                'status' => false,
                'msg' => 'Maximum of Four images allowed'
            ]);
        } else {
            $fileNumb=$check->mult_imgurl+1;
            $uploadedFile = $this->imageUpload($request,$fileNumb,"false");
             DB::update("UPDATE products SET  mult_imgurl =mult_imgurl+:mult_imgurl WHERE productCode = :productCode", [

                    'mult_imgurl' => 1,
                    'productCode' => $input['productCode']
                ]);
            if ($uploadedFile['status']) {
                DB::table('product_images')->insert([
                    'productCode' => $input['productCode'],
                    'img_url' => $uploadedFile['filename'],
                    'subscriber' => Auth::user()->subscriber,
                    'created_at' => $this->today
                ]);

                DB::commit();

                return response()->json([
                    'status' => true,
                    'filename' => $uploadedFile['filename']
                ]);
            } else {
                return response()->json([
                    'status' => false,
                    'msg' => 'Image not uploaded'
                ]);
            }
        }
    } catch (\Exception $e) {
        DB::rollBack();

        return response()->json([
            'error' => 'An error occurred',
            'errorPrint' => $e->getMessage(),
            'errorCode' => $e->getLine(),
        ], 500);
    }
}


public function SetDefault(Request $request){


    $dir = base_path('images/product/'); // Replace with the actual directory path



    $file1 = $request->input('productCode').'_'.Auth::user()->subscriber.'_'.'1.jpg';
    $file2 = $request->input("fileNam");
    for ($i = strlen($file2) - 1; $i >= 0; $i--) {//this is try to get number to be updated

        if (is_numeric($file2[$i])) {

            $number ="numb"."".$file2[$i];
            break;
        }
    }

     $number;

    // Create temporary file names
    $tempFile1 = $dir . 'temp_' . $file1;
    $tempFile2 = $dir . 'temp_' . $file2;

    // Rename the files with detailed error messages
    if (!file_exists($dir . $file1)) {
        echo "Error: File $dir$file1 does not exist.";
        exit;
    }

    if (!file_exists($dir . $file2)) {
        echo "Error: File $dir$file2 does not exist.";
        exit;
    }

    if (rename($dir . $file1, $tempFile1)) {
        if (rename($dir . $file2, $tempFile2)) {
            if (rename($tempFile1, $dir . $file2)) {
                if (rename($tempFile2, $dir . $file1)) {
                    //swap code
                    DB::update("UPDATE products
                    SET img_url = JSON_SET(
                        JSON_SET(
                            img_url,
                            '$.$number',
                            JSON_EXTRACT(img_url, '$.numb1')
                        ),
                        '$.numb1',
                        JSON_EXTRACT(img_url, '$.$number')
                    )
                    WHERE productCode=:productCode and subscriber=:subscriber limit 1",[
                        "productCode"=>$request->input('productCode'),
                        "subscriber"=>Auth::user()->subscriber

                    ]);

                    echo "Files have been swapped successfully.";
                } else {
                    echo "Error: Failed to rename $tempFile2 to $dir$file1.";
                }
            } else {
                echo "Error: Failed to rename $tempFile1 to $dir$file2.";
            }
        } else {
            echo "Error: Failed to rename $dir$file2 to $tempFile2.";
        }
    } else {
        echo "Error: Failed to rename $dir$file1 to $tempFile1.";
    }







}
public function EditImage(Request $request){

    $fileNam=$request->input("fileNam");

   if($this->deleteImage($fileNam))
   {
 return $this->imageUpload($request,$fileNam,"true");
   }
   else{

   }
}
public function deleteImage($fileNam){


    // Path to the image file
    $destinationPath = base_path('images/product');
    $imagePath = $destinationPath.'/'.$fileNam;

    // Check if the file exists
    if (file_exists($imagePath)) {
        // Attempt to delete the file
        if (unlink($imagePath)) {
            return true;
        } else {
            return false;
        }
    } else {
        return false;
    }


    }

    public function SearchSafari($input){
        $item = strtolower($input["name"]);
        $itemSearch='%'.$item.'%';
        $check=DB::select("select *from safaristocks where subscriber=:subscriber and name LIKE :Name
        LIMIT 10",array(
            "subscriber"=>Auth::user()->subscriber,
            'Name'=>$itemSearch
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
    public function GetSafaris($input)
    {
        if($input["searchOption"]=='true') return $this->SearchSafari($input);
        $check=DB::select("select *from safaristocks where subscriber=:subscriber ORDER BY id DESC
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
        $check=DB::table("safaristocks")
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
        $check=DB::update("update safaristocks set name=:name,comment=:comment,updated_at=:updated_at where uid=:uid and subscriber=:subscriber limit 1",array(
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
    public function DeleteSafariStock($input){//note this must hide to avoid delete all my tables

        $check=DB::select("select safariId from safariproducts where safariId=:safariId  limit 1",[
          "safariId"=>$input["uid"],
         ]);
        if($check)
        {

                return response([
                    "status"=>false,
                    "result"=>$check,

                ],200);


        }
        else{
            $check1=DB::delete("delete from safaristocks where uid=:uid limit 1",array(

                "uid"=>$input["uid"]
            ));
            if($check1)
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

    }

    public function PrintQrProduct($input){
        $check=DB::select("select *from products where subscriber=:subscriber and isQr=:isQr",array(
            "subscriber"=>Auth::user()->subscriber,
            "isQr"=>1
            )
        );

        return response([
            "status"=>true,
            "result"=>$check


        ],200);
    }
    public function createQrProduct($input)
    {

        set_time_limit(1000);
        $chunkSize = 50;

        // Process records in chunks
        $check=DB::table('products')
            ->select('price', 'productName', 'productCode')
            ->where('isQr', 0)
            ->orderBy('id')
            ->limit(1)
            ->chunk($chunkSize, function ($products) {
                foreach ($products as $product) {
                    // Update 'isQr' to 1 for each product
                    DB::table('products')
                        ->where('productCode', $product->productCode)
                        ->update(['isQr' => 1]);

                    // Generate QR code for the product
                    $filename = $product->productCode;
                    \QrCode::size(500)
                        ->format('png')
                        ->generate($product->productCode, base_path("images/ProductsQr/{$filename}.png"));
                }
            });
            if($check){
                return response([
                    "status" => true,


                ]);
            }




    }

    public function SearchUser($input){
        if(strtolower($input["isAdmin"])=='true')
        {
            return $this->IsAdmin($input);
        }
        else{
            if(strtolower($input["isStatus"])!=strtolower('offNotPick'))
            {
                return $this->IsPickUser($input);
            }
            else{
                return $this->IsUser($input);
            }

        }


    }
    public function IsPickUser($input){
        $limitData=$input['limitData'];
        $check=DB::select("select name,uid,PhoneNumber,platform from users where subscriber=:subscriber and status=:status LIMIT $limitData", array(
            "status"=>$input['isStatus'],
            "subscriber" => Auth::user()->subscriber
        ));
        if($check) {
            return response([
                "status" => true,

                "result" => $check
            ]);
        } else {
            return response([
                "status" => false,

                "result" => $check
            ]);
        }
    }
    public function IsUser($input)
    {
        $platform=$input['platform'];
        $limitData=$input["limitData"];
        $name=strtolower($input["name"] ?? 'none');
        $phoneNumber=strtolower($input["phoneNumber"] ??'none');

        list($queryData, $itemName) = ($input["phoneNumber"]!='none')
        ? (['PhoneNumber', '%' . $phoneNumber . '%'])
        : (['name', '%' . $name . '%']);


        if(strtolower($input["searchOption"])=='true')
        {
            $check1=DB::select("select name,uid,PhoneNumber,created_at,platform from users where subscriber=:subscriber and platform=:platform and $queryData LIKE :itemName LIMIT $limitData", array(
                "itemName" => $itemName,
                "platform"=>$platform,
                "subscriber" => Auth::user()->subscriber
            ));
            if($check1) {
                return response([
                    "status" => true,

                    "result" => $check1
                ]);
            } else {
                return response([
                    "status" => false,

                    "result" => $check1
                ]);
            }
        }
        else{
            $sortOrder=$input['sortOrder']??'ASC';
            $check=DB::select("select name,uid,PhoneNumber,created_at,platform from users where subscriber=:subscriber and platform=:platform ORDER BY id $sortOrder LIMIT  $limitData", array(
                "platform"=>$platform,
                "subscriber" => Auth::user()->subscriber
            ));
            if($check) {
                return response([

                    "status" => true,

                    "result" => $check
                ]);
            } else {
                return response([
                    "status" => false,

                    "result" => $check
                ]);
            }
        }
    }
    public function IsAdmin($input)
    {
        $platform=$input['platform'];
        $limitData=$input["limitData"];
        $name=strtolower($input["name"] ?? 'none');
        $phoneNumber=strtolower($input["phoneNumber"] ??'none');

        list($queryData, $itemName) = ($input["phoneNumber"]!='none')
        ? (['PhoneNumber', '%' . $phoneNumber . '%'])
        : (['name', '%' . $name . '%']);


        if(strtolower($input["searchOption"])=='true')
        {
            $check1=DB::select("select name,uid,PhoneNumber,platform from admins where subscriber=:subscriber and platform=:platform and $queryData LIKE :itemName LIMIT $limitData", array(
                "itemName" => $itemName,
                "platform"=>$platform,
                "subscriber" => Auth::user()->subscriber
            ));
            if($check1) {
                return response([
                    "status" => true,

                    "result" => $check1
                ]);
            } else {
                return response([
                    "status" => false,

                    "result" => $check1
                ]);
            }
        }
        else{
            $check=DB::select("select name,uid,PhoneNumber,platform from admins where subscriber=:subscriber and platform=:platform LIMIT $limitData", array(
                "platform"=>$platform,
                "subscriber" => Auth::user()->subscriber
            ));
            if($check) {
                return response([
                    "status" => true,

                    "result" => $check
                ]);
            } else {
                return response([
                    "status" => false,

                    "result" => $check
                ]);
            }
        }
    }


    public function Products($input)
    {
        try {
            $isProductAction=strtolower($input["isProductAction"]);
            if($isProductAction=='search')
            {
                return $this->isSearchProduct($input);
            }
            else if($isProductAction==strtolower('searchInStock'))
            {
                $input["safariId"]=$input["productName"];
                return $this->isSearchInStock($input);
            }
            else if(strtolower($isProductAction)==strtolower('searchProductStock'))
            {
                return $this->isSearchProductStock($input);
            }
            else if(strtolower($isProductAction)==strtolower('totalStock'))
            {
                $check=DB::select("SELECT sum(price *(qty-qty_sold)) as totalStock  FROM products where subscriber=:subscriber and qty>0",[
                    "subscriber" =>Auth::user()->subscriber,
                ]);
                if ($check) {
                    return response([
                        "status" => true,

                        "result" => $check
                    ]);
                } else {
                    return response([
                        "status" => false,

                        "result" => $check
                    ]);
                }
            }

            else{
                return $this->isViewProduct($input);
            }
        } catch (\Exception $e) {
            DB::rollback();
            return response()->json([
                'error' => 'An error occurred',
                'errorPrint' => $e->getMessage(),
                'errorCode' => $e->getLine(),
            ], 500);
        }



    }
    public function isSearchInStock($input){

        $check = DB::select("select productCode,safariId from safariproducts where productCode=:productCode and safariId=:safariId limit 1", array(
            "safariId"=>$input["safariId"],
            "productCode"=>strtolower($input["productCode"])

        ));

        if ($check) {
            return response([
                "status" => true,

                "result" => $check
            ]);
        } else {
            return response([
                "status" => false,

                "result" => $check
            ]);
        }
    }

    public function isSearchProduct($input){
        try {
            // Code...
            $productName = strtolower($input["productName"] ?? 'none');
            $productCode = strtolower($input["productCode"] ?? 'none');
            $productQr = strtolower($input["productQr"] ?? 'none');

            if ($productQr == 'none') {
                list($queryData, $itemName) = ($productCode != 'none')
                    ? (['productCode', '%' . $productCode . '%'])
                    : (['ProductName', '%' . $productName . '%']);

                $check = DB::select("select *from products where subscriber=:subscriber and $queryData LIKE :itemName LIMIT 20", array(
                    "itemName" => $itemName,
                    "subscriber" => Auth::user()->subscriber
                ));

                if ($check) {
                    return response([
                        "status" => true,
                        "searchType" => "NotQr",
                        "result" => $check
                    ]);
                } else {
                    return response([
                        "status" => false,
                        "searchType" => "NotQr",
                        "result" => $check
                    ]);
                }
            } else {
                $check = DB::select("select *from products where productCode=:itemName and subscriber=:subscriber LIMIT 1", array(
                    "itemName"=>$input['productCode'],
                    "subscriber" => Auth::user()->subscriber
                ));

                if ($check) {
                    return response([
                        "status" => true,
                        "searchType" => "Qr",
                        "result" => $check
                    ]);
                } else {
                    return response([
                        "status" => false,
                        "searchType" => "Qr",
                        "result" => $check
                    ]);
                }
            }
        } catch (\Exception $e) {
            return response()->json([
                'error' => 'An error occurred',
                'errorPrint' => $e->getMessage(),
                'errorCode' => $e->getLine(),
            ], 500);
        }
    }
    public function isSearchProductStock($input)
    {
        try {
            // Code...
            $productName = strtolower($input["productName"] ?? 'none');
            $productCode = strtolower($input["productCode"] ?? 'none');
            $productQr = strtolower($input["productQr"] ?? 'none');

            if ($productQr == 'none') {
                list($queryData, $itemName) = ($productCode != 'none')
                    ? (['products.productCode', '%' . $productCode . '%'])
                    : (['products.ProductName', '%' . $productName . '%']);

                /*$check = DB::select("select *from products where subscriber=:subscriber and $queryData LIKE :itemName LIMIT 20", array(
                    "itemName" => $itemName,
                    "subscriber" => Auth::user()->subscriber
                ));*/
                $check = DB::select("
                SELECT
                MAX(products.productCode) as productCode,
                MAX(products.ProductName) as ProductName,
                MAX(products.price) as price,
                MAX(products.qty) as qty,
                MAX(products.isQr) as isQr,
                MAX(products.qty_sold) as qty_sold,
                MAX(products.pcs) as pcs,
                MAX(products.tags) as tags
             FROM
                products
             INNER JOIN
                safariproducts ON products.productCode = safariproducts.productCode
             WHERE
                products.subscriber = :subscriber
                AND $queryData LIKE :itemName
             GROUP BY
                safariproducts.productCode
             LIMIT
                20

              ", array(
                    "itemName" => $itemName,
                    "subscriber" => Auth::user()->subscriber
                ));


                if ($check) {
                    return response([
                        "status" => true,
                        "searchType" => "NotQr",
                        "result" => $check
                    ]);
                } else {
                    return response([
                        "status" => false,
                        "searchType" => "NotQr",
                        "result" => $check
                    ]);
                }
            } else {
                $check = DB::select("select *from products where productCode=:itemName and subscriber=:subscriber LIMIT 1", array(
                    "itemName"=>$input['productCode'],
                    "subscriber" => Auth::user()->subscriber
                ));

                if ($check) {
                    return response([
                        "status" => true,
                        "searchType" => "Qr",
                        "result" => $check
                    ]);
                } else {
                    return response([
                        "status" => false,
                        "searchType" => "Qr",
                        "result" => $check
                    ]);
                }
            }
        } catch (\Exception $e) {
            return response()->json([
                'error' => 'An error occurred',
                'errorPrint' => $e->getMessage(),
                'errorCode' => $e->getLine(),
            ], 500);
        }
    }
    public function isViewProduct($input){
          $subscriber=Auth::user()->subscriber;
        $withTotal=($input["withTotal"]==="true")?",(SELECT sum(price *(qty-qty_sold)) from products where subscriber='$subscriber' and qty>0) as totalStock":"";
        $check = DB::select("select productCode,ProductName,price,qty,qty_sold,pcs,tags $withTotal from products where subscriber=:subscriber LIMIT :perPage OFFSET :offset", array(
            "subscriber" =>$subscriber,
            "perPage"=>$input["LimitEnd"]??0,
            "offset"=>$input["LimitStart"]??10
        ));

        if ($check) {
            return response([
                "status" => true,

                "result" => $check
            ]);
        } else {
            return response([
                "status" => false,

                "result" => $check
            ]);
        }
    }
   public function IsProductExist($input)
   {


    // Remove special characters using a regular expression
   // $productCode= str_replace(["'", '"', '`', '%', '_'], '', strtolower($input['productCode']));
   $productCode= strtolower($input['productCode']);
    $checkProduct=DB::select("select productCode from safariproducts where safariId=:safariId and productCode=:productCode and subscriber=:subscriber limit 1",array(
        "safariId"=>$input["safariId"],
        "productCode"=>$productCode,
        "subscriber"=>Auth::user()->subscriber

    ));
    if($checkProduct)
    {
        return response([

            "status"=>true,
            "mydata"=> $productCode,
            "result"=>"ProductExist ,please add another product or adjust"

         ]);
    }
    else
    {
        return response([

            "status"=>false,
            "mydata"=> $productCode,
            "result"=>"you May add This Product"

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

        $checkExist=($input['productName']=='productDataExistandCode')?true:false;//check if ProductCode Exist
        /*$productCode= str_replace(["'", '"', '`', '%', '_'], '', strtolower($input['productCode']));
        $productName= str_replace(["'", '"', '`', '%', '_'], '', strtolower($input['productName']));
        $tags= str_replace(["'", '"', '`', '%', '_'], '', strtolower($input['tags']));*/

        $productCode= strtolower($input['productCode']);
        $productName= strtolower($input['productName']);
        $tags= str_replace(["'", '"', '`', '%', '_'], '', strtolower($input['tags']));
        $description= str_replace(["'", '"', '`', '%', '_'], '', strtolower($input['description']));

        if($checkExist)
        {

            $checkProduct=DB::select("select productCode from safariproducts where safariId=:safariId and productCode=:productCode and subscriber=:subscriber limit 1",array(
                "safariId"=>$input["safariId"],
                "productCode"=>$productCode,
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
                        'productCode'=>$productCode,//product id
                        'subscriber'=>Auth::user()->subscriber


                  // "updated_at"=>$this->today,
                    ));

                if($check)
                {

                    return $this->createInStockProduct($input,$productCode);
                }
                else{
                    return response([

                        "status"=>false,
                        "result"=>$check,
                        "code"=>$productCode,

                        "data"=>"noneim  "

                     ]);
                }

            }

        }
        else{

            /*$uid=preg_replace('/[^A-Za-z0-9-]/','',strtolower($input["productName"]));//generated on production

            $productCode=$uid.""."_".date(time());*/

            $check=DB::table("products")
            ->insert([
        "cat"=>$input['cat']?:'none',//comeFrom
        "catName"=>$input['catName']?:'none',//comeFrom
        'productCode'=>$productCode,//product id
        'productName'=>$productName,//product id

        "subscriber"=>Auth::user()->subscriber,
 //owner of the products
        "price"=>$input['price'],//who give item

        "qty"=>$input['qty'],
        "pcs"=>$input['pcs']?:'none',
       "total"=>$input['qty']*$input['price'],

  // "img_url"=>$mult_imgurl->att_url,
       "img_url"=>"none"?:'none',

      "tags"=>($tags)?:NULL,
      'active'=>$input['active']?:'none',
      "description"=>$description?:'none',
        "created_at"=>$this->today,
            ]);
            if($check)
            {

                return $this->createInStockProduct($input,$productCode);
            }
            else{
                return response([

                    "status"=>false,
                    "data"=>"none",
                    "result"=>$check

                 ]);
            }
        }



    }
    public function createInStockProduct($input,$productCode)//everything related in That Stock
    {
        $stockInterest=$input['safariId']."_"."int";//interest
            $stockDisplay=$input['safariId']."_"."dis";//display Stock

            Cache::put($stockInterest,'',now()->addMinutes(0));//Reset
            Cache::put($stockDisplay,'',now()->addMinutes(0));//Reset

          try {
            //code...

            $check=DB::table("safariproducts")
            ->insert([
                "safariId"=>$input["safariId"],
                "productCode"=>$productCode,//(it may be productCode or uid of spending)
                "price"=>$input["fact_price"],
                "qty"=>$input["qty"],
                "totQty"=>$input["qty"],
                "TotSoldAmount"=>$input["TotSoldAmount"]??"0",
                "TotBuyAmount"=>$input["qty"]*$input["fact_price"],
                "status"=>$input["status"]??"none",
                "CommentStatus"=>$input["CommentStatus"]??"none",

                "uidCreator"=>Auth::user()->uid,
                "subscriber"=>Auth::user()->subscriber,
                "created_at"=>$this->today,
                "updated_at"=>$this->today
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
                    "result"=>$check,
                    "data"=>"noneins"

                 ]);
            }
        }  catch (\Exception $e) {
            DB::rollback();
           // throw $e;
            return response()->json(['error' => 'An error occurred',
        'errorPrint'=>$e->getMessage(),"errorCode"=>$e->getLine()], 500); // Return an error JSON response
        }



    }

    public function updateProducts($input){ //Edit only ProductPrice tempTable is missing


        try {
            $check=DB::select("select price,pcs,ProductName from products where productCode=:productCode and subscriber=:subscriber limit 1",[
                "productCode"=>$input['productCode'],
                "subscriber"=>Auth::user()->subscriber
            ]);

            if($check)
            {
                $json_array=[

                    "prev_Price"=>$check[0]->price,
                    "current_Price"=>$input['price'],
                    "prev_Pcs"=>$check[0]->pcs,
                    "current_Pcs"=>$input['pcs'],
                    "prev_ProductName"=>$check[0]->ProductName,
                   /// "current_ProductName"=>str_replace(["'", '"', '`', '%', '_'], '', strtolower($input['productName'])),
                    "current_ProductName"=>strtolower($input['productName']),
                    "uidCreator"=>Auth::user()->uid,
                    "created_at"=>$this->today

                 ];

                 $data=[
                    "tableName"=>"products",
                    "action"=>$input['actionStatus'],
                    'tempData'=>json_encode($json_array),
                    'status'=>'edit'
                 ];


               if($this->createBackupAction($data))
               {
                if(strtolower($input["actionStatus"])==strtolower('updatePrice'))
                {
                    return $this->isUpdatePrice($input);
                }
                else if(strtolower($input["actionStatus"])==strtolower('updatePcs')){
                    return $this->isUpdatePcs($input);
                }
                else{
                    return $this->isUpdateProductName($input);
                }


                }

                else{
                    return response([
                        "status"=>false,
                        "result"=>$check,

                    ],200);
                }


            }
            //code...
        }  catch (\Exception $e) {
            DB::rollback();
           // throw $e;
            return response()->json(['error' => 'An error occurred',
        'errorPrint'=>$e->getMessage(),"errorCode"=>$e->getLine()], 500); // Return an error JSON response
        }




    }
    public function isUpdatePrice($input){
        $checkDB=DB::update("update products set price=:price,updated_at=:updated_at where productCode=:productCode and subscriber=:subscriber limit 1",array(
            'productCode'=>$input['productCode'],//product id
            'price'=>$input['price'],
            "subscriber"=>Auth::user()->subscriber,
            'updated_at'=>$this->today
            ));
            return response([
                "status"=>true,
                "result"=>$checkDB,

            ],200);
    }
    public function isUpdatePcs($input){
        $checkDB=DB::update("update products set pcs=:pcs,updated_at=:updated_at where productCode=:productCode and subscriber=:subscriber limit 1",array(
            'productCode'=>$input['productCode'],//product id
            'pcs'=>$input['pcs'],
            "subscriber"=>Auth::user()->subscriber,
            'updated_at'=>$this->today
            ));
            return response([
                "status"=>true,
                "result"=>$checkDB,

            ],200);
    }
    public function isUpdateProductName($input){
        $checkDB=DB::update("update products set ProductName=:ProductName,updated_at=:updated_at where productCode=:productCode and subscriber=:subscriber limit 1",array(
            'productCode'=>$input['productCode'],//product id
            //'ProductName'=>str_replace(["'", '"', '`', '%', '_'], '', strtolower($input['productName'])),
            'ProductName'=>strtolower($input['productName']),
            "subscriber"=>Auth::user()->subscriber,
            'updated_at'=>$this->today
            ));
           if($checkDB)
           {
            return response([
                "status"=>true,
                "result"=>$checkDB,

            ],200);
           }
           else{
            return response([
                "status"=>false,
                "result"=>$checkDB,

            ],200);
           }

    }
    public function createBackupAction($data){
       $uid="UID"."_".Str::random(2).""."_".date(time());
        $check=DB::table("histtemp_tables")
        ->insert([
           "uid"=>$uid,
           "tableName"=>$data["tableName"],
           "action"=>$data["action"],
           "tempData"=>$data['tempData'],
           "status"=>$data['status'],
           "uidCreator"=>Auth::user()->uid,
           "subscriber"=>Auth::user()->subscriber,
           "created_at"=>$this->today

        ]);
        if($check)
        {
            return true;
        }

    }

    public function EditProducts($input){ //Edit all Products ProductPrice tempTable is missing
        $checkDB=DB::update("update products set price=:price,productName=:productName,cat=:cat,catName=:catName,tags=:tags,active=:active,pcs=:pcs,updated_at=:updated_at where productCode=:productCode and subscriber=:subscriber limit 1",array(
            'productCode'=>strtolower($input['productCode']),//product id
            'price'=>$input['price'],
            'productName'=>strtolower($input['productName']),
            'cat'=>$input['cat'],
            'catName'=>$input['catName'],
            'tags'=>strtolower($input['tags']),
            'active'=>$input['active'],
            "pcs"=>$input["pcs"],
            "subscriber"=>Auth::user()->subscriber,
            'updated_at'=>$this->today
            ));
    }
    public function deleteStockQty($input) //Edit Stock Qty tempTable is missing
    {



        try {
            $checkDB=DB::transaction(function () use ($input) {//
                $stockInterest=$input['safariId']."_"."int";//interest
                $stockDisplay=$input['safariId']."_"."dis";//display Stock

                Cache::forget($stockInterest);
                Cache::forget($stockDisplay);
                $checkTotQty=DB::select("select productCode,totQty,TotSoldAmount from safariproducts where safariId=:safariId and productCode=:productCode limit 1",[
                    "productCode"=>$input['productCode'],
                    "safariId"=>$input["safariId"],
                ]);
                if($checkTotQty)
                {

                    if($checkTotQty[0]->TotSoldAmount==='0')
                    {
                        $check1=DB::update("update products set qty=qty-:prevQty,updated_at=:updated_at where productCode=:productCode and subscriber=:subscriber limit 1",array(
                            'productCode'=>$input['productCode'],//product id

                            'prevQty'=>$checkTotQty[0]->totQty,
                            "subscriber"=>Auth::user()->subscriber,
                            'updated_at'=>$this->today
                            ));


                            $check = DB::delete("
                            Delete from safariproducts
                            WHERE
                                subscriber = :subscriber
                                AND safariId = :safariId
                                AND productCode = :productCode
                            LIMIT 1",
                            [
                                "productCode" => $input['productCode'],
                                "safariId" => $input["safariId"],
                                "subscriber" => Auth::user()->subscriber

                            ]
                        );
                        return array(
                            "status"=>true,
                            "datacount"=>"resulr"
                         );

                    }
                    else{
                        return array(
                            "status"=>false,

                         );
                    }



                }




            });

                return response($checkDB,200);



        } catch (\Exception $e) {
            DB::rollback();
            // throw $e;
             return response()->json(['error' => 'An error occurred',
         'errorPrint'=>$e->getMessage(),"errorCode"=>$e->getLine()], 500); // Return an error JSON response
        }



    }
    public function EditStockQty($input) //Edit Stock Qty tempTable is missing
    {



        try {
            $checkDB=DB::transaction(function () use ($input) {//
                $stockInterest=$input['safariId']."_"."int";//interest
                $stockDisplay=$input['safariId']."_"."dis";//display Stock

                Cache::forget($stockInterest);
                Cache::forget($stockDisplay);
                $checkTotQty=DB::select("select productCode,totQty,TotSoldAmount from safariproducts where safariId=:safariId and productCode=:productCode limit 1",[
                    "productCode"=>$input['productCode'],
                    "safariId"=>$input["safariId"],
                ]);
                if($checkTotQty)
                {

                    if($checkTotQty[0]->TotSoldAmount==='0')
                    {
                        $check1=DB::update("update products set qty=(qty-:prevQty)+:qty,updated_at=:updated_at where productCode=:productCode and subscriber=:subscriber limit 1",array(
                            'productCode'=>$input['productCode'],//product id
                            'qty'=>$input["qty"],
                            'prevQty'=>$checkTotQty[0]->totQty,
                            "subscriber"=>Auth::user()->subscriber,
                            'updated_at'=>$this->today
                            ));


                            $check = DB::update("
                            UPDATE safariproducts
                            SET
                                totQty = :totQty,
                                qty = :qty,

                                TotBuyAmount = price * :QtyCh,
                                updated_at = :updated_at
                            WHERE
                                subscriber = :subscriber
                                AND safariId = :safariId
                                AND productCode = :productCode
                            LIMIT 1",
                            [
                                "productCode" => $input['productCode'],
                                "safariId" => $input["safariId"],

                                "subscriber" => Auth::user()->subscriber,
                                "totQty" =>$input["qty"],
                                "qty" =>$input["qty"],
                                "QtyCh" =>$input["qty"],
                                "updated_at" => $this->today
                            ]
                        );
                        return array(
                            "status"=>true,
                            "datacount"=>"resulr"
                         );

                    }
                    else{
                        return array(
                            "status"=>false,

                         );
                    }



                }




            });

                return response($checkDB,200);



        } catch (\Exception $e) {
            DB::rollback();
            // throw $e;
             return response()->json(['error' => 'An error occurred',
         'errorPrint'=>$e->getMessage(),"errorCode"=>$e->getLine()], 500); // Return an error JSON response
        }



    }

    public function EditStockFactPrice($input) //Edit Stock Factories price tempTable is missing
    {
        $stockInterest=$input['safariId']."_"."int";//interest
        $stockDisplay=$input['safariId']."_"."dis";//display Stock

        Cache::forget($stockInterest);
        Cache::forget($stockDisplay);
        $checkTotQty=DB::select("select productCode,totQty,TotSoldAmount from safariproducts where safariId=:safariId and productCode=:productCode limit 1",[
            "productCode"=>$input['productCode'],
            "safariId"=>$input["safariId"],
        ]);
        if($checkTotQty)
        {

            if($checkTotQty[0]->TotSoldAmount==='0')
            {
                $check=DB::update("update safariproducts set price=:price,TotBuyAmount=totQty*:currentPrize,updated_at=:updated_at where subscriber=:subscriber and safariId=:safariId and productCode=:productCode  limit 1",array(
                    "productCode"=>$input["productCode"],
                    "safariId"=>$input["safariId"],
                    "subscriber"=>Auth::user()->subscriber,
                     "price"=>$input["price"],
                     "currentPrize"=>$input["price"],


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
            else{
                return response([
                    "status"=>false,
                    "result"=>"none",

                ],201);
               }
        }



    }


    public function DeleteItem($input)
    {
        $safariuid=$input["safariuid"];
        $check=DB::delete("delete from safariproducts where safariuid=:safariuid limit 1",array(

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

        $check=DB::update("update safariproducts set uid=:uid,price=:price,SoldInterest=:SoldInterest,qty=:qty,pcs=:pcs,updated_at=:updated_at,comment=:comment where safariuid=:safariuid and id=:id limit 1",array(
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

         if(strtolower($input["actionStatus"])==strtolower("Search"))
         {
         return $this->displayCalSearch($input);
         }

         else{
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



    }
    public function displayCalSearch($input)
    {
        try {
            // Code...

            $productSearch = strtolower($input["productSearch"] ?? 'none');




                list($queryData, $itemName) = ($input['isproductCode']=='true')
                    ? (['products.productCode', '%' . $productSearch . '%'])
                    : (['products.ProductName', '%' . $productSearch . '%']);

                /*$check = DB::select("select *from products where subscriber=:subscriber and $queryData LIKE :itemName LIMIT 20", array(
                    "itemName" => $itemName,
                    "subscriber" => Auth::user()->subscriber
                ));*/
                $check = DB::select("
                SELECT
                MAX(products.productCode) as productCode,
                MAX(products.ProductName) as ProductName,
                MAX(safariproducts.updated_at) as updated_at,
                MAX(safariproducts.status) as status,
                MAX(safariproducts.safariId) as safariId,
                MAX(safariproducts.id) as id,
                MAX(safariproducts.price) as price,
                MAX(safariproducts.qty) as qty,
                MAX(safariproducts.totQty) as totQty,
                MAX(safariproducts.TotBuyAmount) as TotBuyAmount,
                MAX(safariproducts.SoldOut) as SoldOut,

                MAX(safariproducts.TotSoldAmount) as TotSoldAmount,
                MAX(products.pcs) as pcs
             FROM
                products
             INNER JOIN
                safariproducts ON products.productCode = safariproducts.productCode
             WHERE
                products.subscriber = :subscriber
                AND  safariproducts.safariId=:safariId
                AND  safariproducts.status!='spendSafaris'

                AND $queryData LIKE :itemName
             GROUP BY
                safariproducts.productCode
             LIMIT
                20

              ", array(
                    "itemName" =>$itemName,
                    "safariId" =>$input['safariId'],
                    "subscriber" => Auth::user()->subscriber
                ));


                if ($check) {
                    return response([
                        "status" => true,
                        "searchType" => "NotQr",
                        "result" => $check
                    ]);
                } else {
                    return response([
                        "status" => false,
                        "searchType" => "NotQr",
                        "result" => $check
                    ]);
                }

        } catch (\Exception $e) {
            return response()->json([
                'error' => 'An error occurred',
                'errorPrint' => $e->getMessage(),
                'errorCode' => $e->getLine(),
            ], 500);
        }
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
        FROM safariproducts where safariId=:safariId limit 10000",array(
                "safariId"=>$safariId
             ));



                /* $displayData=DB::select("select * from safariproducts where safariId=:safariId order by updated_at desc limit 10000 ",array(
                    "safariId"=>$safariId
                 ));*/

                 $displayData=DB::select("select * from safariproducts where safariId=:safariId order by updated_at desc limit 10000 ",array(
                    "safariId"=>$safariId
                 ));







             Cache::put($stockInterest,$interest,now()->addMinutes(7200));
             Cache::put($stockDisplay,$displayData,now()->addMinutes(7200));
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

             return $this->placeOrder($input);

            /*return response([
                        "status"=>true,
                        "safariuid"=>$input["req_qty"],
                        "reqType"=>gettype($input["req_qty"]),
                       // "name"=>$input["SafariName"]

                    ],200);*/

    }

    public function updateDataOrder($input)
    {

        if(strtolower($input["isCommentData"])==strtolower('CommentInOrder'))
        {
            return $this->updateCommentInOrder($input);
        }
        else{

            return $this->updateUserInOrder($input);
        }

    }
    public function updateCommentInOrder($input){


        $check=DB::update("update orderhistories set description=:commentData where uid=:uid and productCode=:productCode limit 20",[
            "uid"=>$input['uid'],
            "productCode"=>$input['productCode'],
            "commentData"=>$input['commentData']
        ]);
        if($check){
            return response([
                "status"=>true,
                "result"=>$check

            ],200);
        }
        else{
            return response([
                "status"=>false,
                "result"=>$check

            ],200);
        }
    }
    public function updateUserInOrder($input){

        if(strtolower($input["isStatus"])==strtolower('offNotPick'))
        {
            $input['limitData']=1;
            $input['isStatus']="Default";

         $newUserId=($this->IsPickUser($input));



         $input["newUidUser"]=($newUserId->original["result"][0]->uid);
         return $this->updateUserIN($input);
        }
        else{

            return $this->updateUserIN($input);
        }


    }
    function updateUserIN($input){
        $check=DB::update("update orderhistories set userid=:userid,order_creator=:uidCreator where uid=:uid and subscriber=:subscriber limit 500",[
            "userid"=>$input["newUidUser"],
            "uidCreator"=>Auth::user()->uid,
            "uid"=>$input["uid"],
            "subscriber"=>Auth::user()->subscriber
          ]);
          if($check){
              return response([
                  "status"=>true,
                  "result"=>$check

              ],200);
          }
          else{
              return response([
                  "status"=>false,
                  "result"=>$check

              ],200);
          }
    }

    public function placeOrder($input){

        $req_qty=$input['req_qty'];
        $productCode=$input['productCode'];
        $input['statusForm']??'none';
        $currentQtyOfOrder=$input['currentQtyOfOrder']??0;
       // $req_qtyProduct=$input['req_qtyFromorderEdit']??$input['req_qty'];
          $SignChange=($input['statusForm']=='editOrder')?"-$currentQtyOfOrder+":'+';
        //list($QueryFactory,$myArray) = ($input['statusForm']=='editOrder') ? [$QueryFactoryDelete,$sqlDelete,$myArrayDelete] : [$QueryFactoryUpdate,$sqlUpdate,$myArrayUpdate];
        $orderId=$input['orderIdFromEdit']??'none';
        $uid =($orderId=='none')?"UID"."_".Str::random(2).""."_".date(time()):$orderId;
       // echo $uid;
        $checkDup=DB::select("select  uid from orderhistories where uid=:uid and paidStatus=:paidStatus limit 1",[
            "uid"=>$uid,
            "paidStatus"=>'checked'
            ]);
        if($checkDup){
                 //Some Duplicate please
                 echo"not exist";
        }
        else{
        //Working
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
                safariproducts
                WHERE
                    subscriber='$subscriber' and
                    productCode='$productCode' AND
                    qty != 0 AND
                    @requested_qty > 0
                ORDER BY
                    id;
            ");



                return $this->testorderPlace($results,$input,$uid);
         }
         else{

        return response([
                "status"=>false,
                "message"=>'Something Wrong check if you have enough qty of '."".$productCode,
                 ],200);
         }

        }


    }
    public function testorderPlace($results,$input,$uid){
        $req_qty=$input['req_qty'];
        $productCode=$input['productCode'];
        $product=DB::select("select price from products where subscriber=:subscriber and productCode=:productCode limit 1",array(
         "productCode"=>$productCode,
         "subscriber"=>Auth::user()->subscriber
        ));
        //$orderId=$input['orderIdFromEdit']??'none';
        //$uid =($orderId=='none')?"UID"."_".Str::random(2).""."_".date(time()):$orderId;
        $data=[];
        $ids=[];
          $limitData=count($results);
        for($i=0;$i<$limitData;$i++)
        {
            if($results[$i]->qty>0)
            {
            $id=$results[$i]->id;
            $ids[]=$results[$i]->id;
            $data[] = [
                //'uid' =>$input["orderIdFromEdit"]??$uid,
                'uid' =>$uid,
                'userid'=>$input['uidClient'],
                'safariId'=>$results[$i]->safariId,
                "order_creator"=>Auth::user()->uid,
                "subscriber"=>Auth::user()->subscriber,
                'productCode'=>$productCode,
                'price'=>$product[0]->price,
                'qty'=>$results[$i]->qty,
                'qty_count'=>$results[$i]->qty,
                'total'=>$results[$i]->qty*$product[0]->price,
                'OrderData'=>json_encode([]),
                'comment_count'=>json_encode([]),
                "created_at"=>$this->today,
                "updated_at"=>$this->today


                // Add more rows here if needed
            ];

            $SoldOut=$results[$i]->qty;
            $totAm=$SoldOut*$product[0]->price;
            $qtyData=abs($results[$i]->remaining);
           DB::update("update safariproducts set qty=:qty,SoldOut=SoldOut+$SoldOut,TotSoldAmount=TotSoldAmount+$totAm where safariId=:safariId and productCode=:productCode and subscriber=:subscriber limit $limitData",array(
           "qty"=>$qtyData,
           "subscriber"=>Auth::user()->subscriber,
           "safariId"=>$results[$i]->safariId,
           "productCode"=>$productCode,

           ));
        }

        }



            $checkInsert=DB::table("orderhistories")
            ->insert($data);
            /*DB::update("update orders set userid=:userid where uid='1' limit 1",array(
                'userid' =>'kati6'
                ));*/


    if($checkInsert)
    {

        return response([

            "status"=>true,
            //"result"=>$results,

            "OrderId"=>$uid,
            //"data"=>$data



            ],200);
    }
    else{
        return response([

            "status"=>false,
            //"result"=>$results,


            //"data"=>$data



            ],200);
    }





    }
    public function productEditOrder($input){//idea behind this is first to reset cart (orderhistory),and start as new one


        try {
            $check=DB::transaction(function () use ($input) {
                $req_qty=$input['req_qty'];
                   $currentQtyEdit=abs($input['currentQtyEdit']);
                   $productCode=$input['productCode'];
            /* DB::select("select *from orderhistories where uid=:uid and productCode=:productCode and uidUser=:uidUser",[
               "uid"=>
               "uidClient"
             ])*/

             $checkProduct=DB::select("select productCode,subscriber,price from products where subscriber=:subscriber and productCode=:productCode and qty>=(qty_sold-:currentQtyEdit)+:req_qty limit 1",array(
               "productCode"=>$productCode,
               "req_qty"=>$input['req_qty'],
               "currentQtyEdit"=>abs($input['currentQtyEdit']),
               "subscriber"=>Auth::user()->subscriber
            ));
            if($checkProduct)
            {
           $results= DB::select("select *from orderhistories where uid=:uid and productCode=:productCode ",[
               "uid"=>$input['uid'],
               "productCode"=>$input['productCode'],

           ]);
           $limitData=count($results);
           $totalQty=0;
           $countLoop=0;
           for($i=0;$i<$limitData;$i++)
           {

               $id=$results[$i]->id;
               $ids[]=$results[$i]->id;
               $orderId=$results[$i]->uid;
               DB::update("update safariproducts set qty=qty+:qty,SoldOut=SoldOut-:SoldOut,TotSoldAmount=TotSoldAmount-:TotSoldAmout where safariId=:safariId and productCode=:productCode limit 100 ",array(
                   "qty"=>$results[$i]->qty,
                   "SoldOut"=>$results[$i]->qty,
                   "TotSoldAmout"=>$results[$i]->total,
                   "safariId"=>$results[$i]->SafariId,
                   "productCode"=>$results[$i]->productCode

            ));
            $countLoop=$i+1;
           $totalQty+=$results[$i]->qty;




           }
           if($results){
              //echo $limitData;
               if($countLoop>=$limitData){

                   DB::delete("delete from orderhistories where uid=:uid and productCode=:productCode limit 50",array(
                       "uid"=>$input['uid'],
                       "productCode"=>$input['productCode']

                       ));
                       $checkUpdate=DB::update("update products set qty_sold=(qty_sold-:currentQty)+:req_qty where subscriber=:subscriber and productCode=:productCode limit 1",[
                           "currentQty"=>$totalQty,
                           "req_qty"=>$input['req_qty'],
                           "productCode"=>$input['productCode'],
                           "subscriber" => Auth::user()->subscriber
                       ]);
                       $subscriber=Auth::user()->subscriber;
                       $productCode=$input['productCode'];
                       DB::select("SET @requested_qty = ?",[$req_qty]);

                       $searchResult = DB::select("
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
                           safariproducts
                           WHERE
                               subscriber='$subscriber' and
                               productCode='$productCode' AND
                               qty != 0 AND
                               @requested_qty > 0
                           ORDER BY
                               id;
                       ");

                       $searchLimitData=count($searchResult);
                       for($i=0;$i<$searchLimitData;$i++)
                       {
                        if($searchResult[$i]->qty>0)
                        {
                           $id=$searchResult[$i]->id;
                           $ids[]=$searchResult[$i]->id;
                           $data[] = [
                               //'uid' =>$input["orderIdFromEdit"]??$uid,
                               'uid' =>$input['uid'],
                               'userid'=>$input['uidClient'],
                               'safariId'=>$searchResult[$i]->safariId,
                               "order_creator"=>Auth::user()->uid,
                               "subscriber"=>Auth::user()->subscriber,
                               'productCode'=>$productCode,
                               'price'=>$checkProduct[0]->price,
                               'qty'=>$searchResult[$i]->qty,
                               'qty_count'=>$searchResult[$i]->qty,
                               'total'=>$searchResult[$i]->qty*$checkProduct[0]->price,
                               'OrderData'=>json_encode([]),
                               'comment_count'=>json_encode([]),
                               "created_at"=>$this->today,
                               "updated_at"=>$this->today


                               // Add more rows here if needed
                           ];

                           $SoldOut=$searchResult[$i]->qty;
                           $totAm=$SoldOut*$checkProduct[0]->price;
                           $qtyData=abs($searchResult[$i]->remaining);
                          DB::update("update safariproducts set qty=:qty,SoldOut=SoldOut+$SoldOut,TotSoldAmount=TotSoldAmount+$totAm where safariId=:safariId and productCode=:productCode and subscriber=:subscriber limit $searchLimitData",array(
                          "qty"=>$qtyData,
                          "subscriber"=>Auth::user()->subscriber,
                          "safariId"=>$searchResult[$i]->safariId,
                          "productCode"=>$productCode,

                          ));
                        }

                       }


                       $checkInsert=DB::table("orderhistories")
                       ->insert($data);
                    if($checkInsert){
                        return array(
                            "status"=>true,
                            "message"=>"testDa enough"
                        );
                    }
                    else{
                        return array(
                            "status"=>false,
                            "message"=>"something Wrong"
                        );
                    }

               }

           }

            }
            else{
                return array(
                    "status"=>false,
                    "message"=>"Not Enough Qty in Stock"
                );
               //not enough product to edit
            }

            });
            return response($check,200);
        } catch (\Exception $e) {
            DB::rollback();
            return response()->json([
                'error' => 'An error occurred',
                'errorPrint' => $e->getMessage(),
                'errorCode' => $e->getLine(),
            ], 500);
        }




        }
public function deleteTSingleOrder($input){
    //$req_qty=$input['req_qty'];
    try {
        $check=DB::transaction(function () use ($input) {
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
                    $countLoop=0;
               for($i=0;$i<$limitData;$i++)
               {

                   $id=$results[$i]->id;
                   $ids[]=$results[$i]->id;
                   $orderId=$results[$i]->uid;

                  DB::update("update safariproducts set qty=qty+:qty,SoldOut=SoldOut-:SoldOut,TotSoldAmount=TotSoldAmount-:TotSoldAmout where safariId=:safariId and productCode=:productCode limit 100 ",array(
                          "qty"=>$results[$i]->qty,
                          "SoldOut"=>$results[$i]->qty,
                          "TotSoldAmout"=>$results[$i]->total,
                          "safariId"=>$results[$i]->SafariId,
                          "productCode"=>$results[$i]->productCode

                   ));


                       $countLoop=$i+1;
   $totalQty+=$results[$i]->qty;
               }
               $input['currentQtyOfOrder']=$totalQty;
               if($results){
                if($countLoop>=$limitData){
                    DB::delete("delete from orderhistories where uid=:uid and productCode=:productCode limit 50",array(
                        "uid"=>$input['uid'],
                        "productCode"=>$input['productCode']


                        ));
                       $checkProduct=DB::update("update products set qty_sold=qty_sold-$totalQty where subscriber=:subscriber and productCode=:productCode  limit 1",array(
                           "productCode"=>$productCode,
                           "subscriber"=>Auth::user()->subscriber
                        ));
                        if($checkProduct)
                        {

                           return array(
                            "status"=>true,
                            "result"=> $checkProduct,
                        );

                        }
                        else{
                            return array(
                                "status"=>true,
                                "result"=> $checkProduct,
                            );
                        }
                   }

               }

            });
        return response($check,200);
    } catch (\Exception $e) {
        DB::rollback();
        return response()->json([
            'error' => 'An error occurred',
            'errorPrint' => $e->getMessage(),
            'errorCode' => $e->getLine(),
        ], 500);
    }

}
public function deleteTOrder($input){


   // $current_qty=$input['current_qty'];
    $uid=$input['uid'];
    $subscriber=Auth::user()->subscriber;
    $results=DB::select("select *FROM
    orderhistories
WHERE
    uid=:uid AND
    paidStatus='none' AND
    subscriber=:subscriber limit 200",
    [
       "uid"=>$uid,
       "subscriber"=>$subscriber
    ]
);


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

       DB::update("update safariproducts set qty=qty+:qty,SoldOut=SoldOut-:SoldOut,TotSoldAmount=TotSoldAmount-:TotSoldAmout where safariId=:safariId and productCode=:productCode limit 100 ",array(
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
public function EditOrder($input){

    //Clone First
    //deleteAll pending Order
    //then create Backup of That orders edited
    //reverse any promotion if existed
    //then change Status
    //When cloned must be visible to all admins to know that someone edited that rows
    //Then superAdmin will only be able to remove that redwarning to order UID


    try {

        $check=DB::transaction(function () use ($input) {
     //

$actionStatus=($input["orderAction"])??"EditOrder";
//dettes must be selected too
$check1 = DB::select("
    SELECT
        ('$actionStatus') as orderAction,
        ('$this->today') as updated_at,
        (orders.debt) as orderDebt,
        (orders.paidStatus) as orderPaidStatus,
        (orders.promotionUid) as orderPromotionUid,
        (orders.reach) as orderReach,
        (orders.gain) as orderGain,
        orderhistories.uid,
        orderhistories.userid,
        orderhistories.safariId,
        orderhistories.order_creator,
        orderhistories.subscriber,
        orderhistories.productCode,
        orderhistories.price,
        orderhistories.qty,
        orderhistories.qty_count,
        orderhistories.OrderData,
        orderhistories.comment_count,
        orderhistories.clientId,
        orderhistories.ref,
        orderhistories.total,
        orderhistories.all_total,
        orderhistories.custom_price,
        orderhistories.custom_total,
        orderhistories.status,
        orderhistories.paidStatus,
        orderhistories.permission,
        orderhistories.description,
        orderhistories.order_created,
        orderhistories.created_at,
        orderhistories.promotionUid,
        orderhistories.bonusType,
        orderhistories.bonusValue,
        orderhistories.giftId,
        orderhistories.giftQty
    FROM
        orderhistories
    INNER JOIN
        orders ON orders.uid = orderhistories.uid
    WHERE
        orders.uid =:orderId
        AND orders.uidCreator=:uidCreator
        AND (orders.paidStatus='dettes' OR orders.paidStatus='paid' OR orders.paidStatus='paidReturn')
", [
    "orderId" =>$input["uid"],
    "uidCreator" =>Auth::user()->uid
]);


if($check1)
{
    $this->deleteOGOrder($input);
$dataInsert=array_map(function ($item) {
   return (array) $item;
}, $check1);
$isBackup=DB::table("orderhistories_backup")
   ->insert($dataInsert);
   if($isBackup)
   {
     //reverse promotion orders here is missing
     //Then delete orders orderUid,Then update orderHistories
     $checkDB=DB::delete("delete from orders where uid=:uid limit 1",[
       "uid"=>$input["uid"]
     ]);
     if($checkDB)
     {
        //just reset admin_records too dettes and submit
        DB::update("update admnin_records set balance=balance-:balance,dettes=dettes-:dettes where uid=:uid and status='Sales' limit 1",[
         "uid"=>Auth::user()->uid,
        "balance"=>$check1[0]->all_total,
         "dettes"=>$check1[0]->orderDebt
        ]);
       DB::update("update orderhistories set paidStatus='none',permission='false',orderDebt=:orderDebt where uid=:uid",[
           "uid"=>$input["uid"],
           "orderDebt"=>$check1[0]->orderDebt
       ]);
     }

   }
}

     //


   });
   return response([

    "status"=>true,


    "result"=>$check,
    //"data"=>$data



    ],200);

       } catch (\Exception $e) {
           return response()->json([
               'error' => 'An error occurred',
               'errorPrint' => $e->getMessage(),
               'errorCode' => $e->getLine(),
           ], 500);
       }

}

public function deleteOGOrder($input){


    // $current_qty=$input['current_qty'];
     $uid=$input['uid'];
     $subscriber=Auth::user()->subscriber;
     $results=DB::select("select *FROM
     orderhistories
 WHERE
     order_creator=:order_creator AND
     paidStatus='none' AND
     subscriber=:subscriber limit 200",
     [
        "order_creator"=>Auth::user()->uid,
        "subscriber"=>$subscriber
     ]
 );


     $data=[];
     $ids=[];

       $limitData=count($results);
          $totalQty=0;
     for($i=0;$i<$limitData;$i++)
     {
         $totalQty+=$results[$i]->qty;
         $id=$results[$i]->id;
         $ids[]=$results[$i]->id;
         $orderId=$results[$i]->uid;
         $qty=$results[$i]->qty;

        DB::update("update safariproducts set qty=qty+:qty,SoldOut=SoldOut-:SoldOut,TotSoldAmount=TotSoldAmount-:TotSoldAmout where safariId=:safariId and productCode=:productCode limit 100 ",array(
                "qty"=>$results[$i]->qty,
                "SoldOut"=>$results[$i]->qty,
                "TotSoldAmout"=>$results[$i]->total,
                "safariId"=>$results[$i]->SafariId,
                "productCode"=>$results[$i]->productCode

         ));
         DB::delete("delete from orderhistories where uid=:uid and productCode=:productCode limit 50",array(
             "uid"=>$orderId,
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
                MAX(orderhistories.userid) AS userid,
                MAX(orderhistories.orderDebt) AS orderDebt,
                MAX(orderhistories.permission) AS permission,
                MAX(orderhistories.description) AS commentData,
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
            WHERE orderhistories.order_creator=:orderCreator
                AND orderhistories.subscriber=:subscriber
                AND orderhistories.paidStatus='none'
            GROUP BY orderhistories.productCode order by orderhistories.id desc

        ", [

            'orderCreator' => Auth::user()->uid,
            'subscriber' => Auth::user()->subscriber,
        ]);
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



    } catch (\Exception $e) {
        return response()->json(['error' => 'An error occurred', 'errorPrint' => $e->getMessage(), 'errorCode' => $e->getLine()], 500);
    }







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

public function sendSwipe($input){//who paid and want that,whom he paid to get ownership of this sales
    //SwapId//is someone Who want to Swap,not done



    $check=DB::update("update orders set swapId=:swapId,swapStatus=:swapStatus,orderDate=:orderDate where uid=:uid and uidCreator=:uidCreator",[
        "uid"=>$input["uid"],
        "swapId"=>Auth::user()->uid,
        "uidCreator"=>$input["ownerSwap"],
        "swapStatus"=>$input['swapStatus'],
        "orderDate"=>$input['orderDate']
    ]);
    DB::update("update orderhistories set order_creator=:order_creator where uid=:uid",[
        "uid"=>$input["uid"],
        "order_creator"=>$input["ownerSwap"],

    ]);
}
public function swipeSales($input){//not done
    if(Auth::guard('Admin')->attempt([


        'password'=>$input['password'],


    ]))
    {

        $DB::update("update admnin_records set balance where status=:  ");
    }
    else{

    }


}
public function SubmitOrder($input){

        $check_InputData=$input['all_total']-$input['inputData'];//all_total :niyo total ya orders,custom_price or inputData=niyo client yishyuye cash

        if($input['all_total']>$input['inputData'])
        {
            return $this->admin_record($input);
        }
        else{
           return $this->admin_record($input);


           //return (new ParticipateController)->participate($input);



        }

//$check_InputData<=0?(new ParticipateController)->participate($input):$this->notparticipate();//means client azaba yishyuye yose nta deni afite

    }
public function admin_record($input){


        try{


            $checks=DB::transaction(function () use ($input) {
                $uidCreator=Auth::user()->uid; //is the one who will pay money to client when he will withdraw
            $subscriber=Auth::user()->subscriber;
            $systemUid=$input['systemUid'];
            $mamaUid="MSolange_1709926940";
            $UserId=($input["uidUser"]===$mamaUid)?$mamaUid:Auth::user()->uid;



            $checkSum=DB::select("select sum(total) as total from orderhistories where uid=:uid limit 2000",[
                "uid"=>$input["OrderId"]
            ]);


    //
           if($checkSum){
            $input['all_total']=$checkSum[0]->total;

            DB::update("update orderhistories set

            all_total=:all_total,custom_price=:custom_price,
            paidStatus ='checked',orderDebt=:orderDebt,order_creator=:order_creator
            where uid=:uid and userid=:userid limit 100",array(
                "uid"=>$input["OrderId"],
                "userid"=>$input["uidUser"],
                "orderDebt"=>$input['all_total']-$input['inputData'],
                "all_total"=>$input['all_total'],
                "custom_price"=>$input['inputData'],
                "order_creator"=>$UserId



            ));

            $paidStatus = ($input['inputData'] == $input['all_total']) ? 'paid' : (($input['inputData'] > $input['all_total']) ? 'paidReturn' : 'dettes');

            $json_array =  [
                [
                "uid"=>$input["OrderId"],//orderId
                "total"=>$input['all_total'],
                "paid"=>$input['inputData'],
                "debt"=>$input['all_total']-$input['inputData'],
                "promotionUid"=>$input['uid'],
                "reach"=>$input['reach'],
                "gain"=>$input['gain'],
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
                "promotionUid"=>$input['uid'],
                "reach"=>$input['reach'],
                "gain"=>$input['gain'],
                "systemUid"=>$systemUid,
                "uidUser"=>($input['uidUser']??$uidCreator),
               // "uidCreator"=>$uidCreator,
                "uidCreator"=>$UserId,
                "subscriber"=>$subscriber,
                "temporalData"=>json_encode($json_array),
                "commentData"=>$input['commentData']??'none',
                "created_at"=>$this->today,
                "updated_at"=>$this->today
            ] );


                $check=DB::update("update admnin_records set balance=balance+:balance,dettes=dettes+:dettes where uid=:uid and systemUid=:systemUid limit 1",array(
                   // "uid"=>$uidCreator,
                    "uid"=>$UserId,
                    "systemUid"=>$input['systemUid'],
                    "balance"=>$input['all_total'],
                    "dettes"=>($input['all_total']-$input['inputData'])
                ));
                if($check)
                {
                    return $check;
                }
                else{
                    $dataInsert=DB::table("admnin_records")
                    ->insert([
                       // "uid"=>$uidCreator,
                       "uid"=>$UserId,
                        "subscriber"=>$subscriber,
                        "systemUid"=>$input['systemUid'],
                        "status"=>'Sales',
                        "balance"=>$input['all_total'],
                        "dettes"=>($input['all_total']-$input['inputData'])

                    ]);
                    return $dataInsert;
                }
           }
 });


            return response([

                "status"=>true,
                "result"=>$checks,





                ],200);


            } catch (\Exception $e) {
                DB::rollback();
               // throw $e;
                return response()->json(["status"=>false,'error' => 'An error occurred',
            'errorPrint'=>$e->getMessage(),"errorCode"=>$e->getLine()], 500); // Return an error JSON response
            }

    }
    public function SearchSales($input)
    {
        $item = strtolower($input["name"]);
        $itemSearch='%'.$item.'%';
        $check = DB::select("
        SELECT
            Max(orders.uid) as OrderId,
            MAX(users.name) AS name,
            Max(admnin_records.balance) AS saleBalance,
            MAX(orders.total) AS totalPaid,
            MAX(orders.created_at) AS created_at,
            MAX(orders.paidStatus) as paidStatus
        FROM orders
        INNER JOIN admnin_records ON orders.uidCreator =admnin_records.uid
        INNER JOIN users ON orders.uidUser = users.uid
        WHERE orders.subscriber = :subscriber
            AND orders.uidCreator = :uidCreator
            AND admnin_records.status ='Sales'
            AND admnin_records.subscriber=:adminSubscriber
            AND users.name LIKE :Name

            GROUP BY orders.id


        LIMIT 10
    ", [
        'subscriber' => Auth::user()->subscriber,
        'adminSubscriber' => Auth::user()->subscriber,
        'uidCreator' => Auth::user()->uid,
        'Name'=>$itemSearch
    ]);

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
    }
    public function viewSales($input){
      //if($input["searchOption"]=='true') return $this->SearchSales($input);

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
            "TopQuery"=>"Max(total_orders.saleBalance) as saleBalance,
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
         Max(orders.uid) as OrderId,
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
    /*public function viewSales($input){//this Working but not minified
        if($input["searchOption"]=='true') return $this->SearchSales($input);

              $check = DB::select("
          SELECT
              Max(orders.uid) as OrderId,
              MAX(users.name) AS name,
              Max(admnin_records.balance) AS saleBalance,
              MAX(orders.total) AS totalPaid,
              MAX(orders.created_at) AS created_at,
              MAX(orders.paidStatus) as paidStatus
          FROM orders
          INNER JOIN admnin_records ON orders.uidCreator =admnin_records.uid
          INNER JOIN users ON orders.uidUser = users.uid
          WHERE orders.subscriber = :subscriber
              AND orders.uidCreator = :uidCreator
              AND admnin_records.status ='Sales'
              AND admnin_records.subscriber=:adminSubscriber

              GROUP BY orders.id
              ORDER BY orders.id DESC

          LIMIT 100
      ", [
          'subscriber' => Auth::user()->subscriber,
          'adminSubscriber' => Auth::user()->subscriber,
          'uidCreator' => Auth::user()->uid,
      ]);

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



      }*/
    public function viewSalesByUid($input){
        try {

            try {
                $check = DB::select("
                SELECT

                    MAX(orderhistories.uid) AS uid,
                    MAX(1) AS hideAddCart,
                    MAX(1) AS currentQty,
                    orderhistories.productCode,
                    MAX(products.productName) AS productName,
                    MAX(orderhistories.price) AS price,
                    MAX(products.pcs) AS pcs,
                    SUM(orderhistories.qty) AS totalQty,
                    SUM(orderhistories.total) AS totalAmount,
                    SUM(orderhistories.qty_count) AS totalCount
                FROM orderhistories
                INNER JOIN products ON orderhistories.productCode = products.productCode

                WHERE orderhistories.uid =:orderId
                    AND orderhistories.subscriber=:subscriber

                GROUP BY orderhistories.productCode order by orderhistories.id desc

            ", [

                'orderId' =>$input["orderId"],
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
    public function SingleDebt($input){
        $phoneNumber=$input['PhoneNumber']??'none';
        $phoneNumber=$input['PhoneNumber']??'none';
        $cardUid=$input['cardUid']??'none';
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
                    "testUser"=>Auth::user()->email

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
    public function PaidDept($input){




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
             $all_total=$input['all_total']??'none';
             $ref=$input['ref']??'none';
             $systemUid=$input['systemUid']??'none';
             $uidCreator=Auth::user()->uid;
             $subscriber=Auth::user()->subscriber;
             $commentData=$input["commentData"]??'none';
             $status=$input["status"]??'PaidDette';
         // this query will give you a list of how much you will pay every Admin in This Company by dividing according,based on every someone you have debts

         $checkData = DB::select("
         SELECT SUM(debt) AS total_debt
         FROM orders
         WHERE uidUser = :uidUser AND subscriber = :subscriber AND debt != '0'
         HAVING total_debt >= :sumDebt
     ", [
         'uidUser' => $uidUser,
         'subscriber' => $subscriber,
         'sumDebt' => $inputData
     ]);

         if($checkData){
         //code
         DB::select("SET @requested_qty=?",[$inputData]);
         $data=DB::select("SELECT
         id,
         uid,
         debt AS prevDebt,
         uidCreator,
         systemUid,
         CASE
             WHEN @requested_qty >= debt THEN debt
             ELSE @requested_qty
         END AS debt,
         CASE
             WHEN @requested_qty >= debt THEN 0
             ELSE @requested_qty - debt
         END AS remaining,
         CASE
             WHEN @requested_qty >= debt THEN 'paid'
             ELSE 'dettes'
         END AS new_status,


         @requested_qty := GREATEST(@requested_qty - debt, 0) AS updated_requested_qty

     FROM
         orders
     WHERE
        uidUser=:uidUser AND
        subscriber=:subscriber AND
         debt != 0 AND
         @requested_qty > 0
     ORDER BY
         id",array(
            "uidUser"=>$uidUser,
            "subscriber"=>$subscriber
         ));
         $paid="PID"."_".Str::random(2).""."_".date(time());
         $dataLimit=count($data);
         for($i=0;$i<$dataLimit;$i++)
         {
            $debtRemain=abs($data[$i]->remaining);
            $id=$data[$i]->id;
            $status=$data[$i]->new_status;
            $paidAmount=$data[$i]->debt;
             $json_array =  [
                 [

                    "uid"=>$data[$i]->uid,//orders ID
                     "uidUser"=>$uidUser,
                     "uidReceiver"=>$data[$i]->uidCreator,//owner of dettes
                     "uidCreator"=>$uidCreator,//who received amount as admin
                     "amount"=>$paidAmount,//amount Paid
                     "totalDebt"=>$checkData[0]->total_debt,//previous total debt
                     "InputAmount"=>$inputData,//amount Submitted
                     "paidStatus"=>(($data[$i]->uidCreator==$uidCreator?'paidReceived':'PaidAdminNotReceived')),//
                     "ref"=>$input['ref']??'none',
                     "PrevDebt"=>$data[$i]->prevDebt,//PrevDebt
                     "remain"=>$debtRemain,//Debt Remain
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
                 "amount"=>$paidAmount,//amount
                 "safeAmount"=>$paidAmount,//amount
                 "tot_paid"=>$inputData,
                 "paid_id"=>$paid,
                 "paidStatus"=>(($data[$i]->uidCreator==$uidCreator?'paidReceived':'PaidAdminNotReceived')),//
                 "temporalData"=>json_encode($json_array),
                 "systemUid"=>$data[$i]->systemUid,
                 "subscriber"=>$subscriber,
                 "commentData"=>$input['commentData']??'none',
                 "created_at"=>$this->today
             ]);
             DB::update("UPDATE orders
                 SET debt = :debtRemain,
                     paidStatus = :status
                 WHERE id = :id
                     AND subscriber = :subscriber
                 LIMIT :limitData",
                 [
                     "debtRemain"=>$debtRemain,
                     "status"=>$status,
                     "id"=>$id,
                     "subscriber"=>Auth::user()->subscriber,
                     "limitData"=>$dataLimit,
                 ]
    );
    $Query1="update admnin_records set dettes=dettes-:dettes";
    $QueryArray1=array(
        "uid"=>$data[$i]->uidCreator,
        "subscriber"=>Auth::user()->subscriber,
        "systemUid"=>$data[$i]->systemUid,
        "status"=>"Sales",
        "dettes"=>$paidAmount
     );
     $Query2="update admnin_records set safeBalance=safeBalance+:safeBalance,dettes=dettes-:dettes";
    $QueryArray2=array(
        "uid"=>$data[$i]->uidCreator,
        "subscriber"=>Auth::user()->subscriber,
        "systemUid"=>$data[$i]->systemUid,
        "status"=>"Sales",
        "safeBalance"=>$paidAmount,
        "dettes"=>$paidAmount
     );
    $Query3="update admnin_records set borrowBalance=borrowBalance+:borrowBalance";
    $QueryArray3=[
        "uid"=>Auth::user()->uid,
        "subscriber"=>Auth::user()->subscriber,
        "systemUid"=>$data[$i]->systemUid,
        "status"=>"Sales",
        "borrowBalance"=>$paidAmount
    ];


        $updateAdmin='DB::select("update admnin_records set borrowBalance=borrowBalance+:borrowBalance where uid=:uid and status=:status and systemUid=:systemUid and subscriber=:subscriber", $QueryArray3)';

        list($Query,$QueryArray,$lastQuery)=($data[$i]->uidCreator==$uidCreator)?[$Query1,$QueryArray1,""]:[$Query2,$QueryArray2,eval('return ' . $updateAdmin . ';')];


    DB::update("$Query where uid=:uid and status=:status and systemUid=:systemUid and subscriber=:subscriber",$QueryArray);



         }
         return array(
            //"data"=>$checkData[0]->total_debt,
            "status"=>true,
            "message"=>"Payment Received"


         );
         //End code

         }else{
            return array(
                "status"=>false,
                "message"=>"Please Try Again, amount Paid is greater that debt client has ,contact system Admin"


             );
         }



        });

        //return response()->json(['status'=>true,'message' => 'Payment Received',"data"=>$check], 200);

        return response($check,200);
            } catch (\Exception $e) {
                     DB::rollback();
                    // throw $e;
                     return response()->json(['error' => 'An error occurred',
                 'errorPrint'=>$e->getMessage(),"errorCode"=>$e->getLine()], 500); // Return an error JSON response
                 }

    }
    public function EditPaidDept($input){

    }

    public function viewDept($input){
       $viewAll=$input["viewAll"]??'false';
       if(strtolower($viewAll)=='false')
       {

        return $this->viewSingleDept($input);
       }
       else{

        return $this->viewAllDept($input);
       }


    }


    public function SearchSingleDept($input)
    {
        $item = strtolower($input["name"]);
        $itemSearch='%'.$item.'%';
        $check = DB::select("
        SELECT
        Max(orders.uidUser) as myDeptId,
        MAX(users.name) AS name,
        Max(admnin_records.dettes) AS totDept,
        Max(orders.debt) AS debt
        FROM orders
        INNER JOIN admnin_records ON orders.uidCreator =admnin_records.uid
        INNER JOIN users ON orders.uidUser = users.uid
        WHERE orders.subscriber=:subscriber
            AND orders.uidCreator = :uidCreator
            AND admnin_records.status ='Sales'
            AND admnin_records.subscriber=:adminSubscriber
            AND orders.paidStatus='dettes'
            AND orders.debt>0
            AND users.name LIKE :Name
            GROUP BY orders.uidUser
            ORDER BY orders.id ASC


    ", [
        'subscriber' => Auth::user()->subscriber,
        'adminSubscriber' => Auth::user()->subscriber,
        'uidCreator' => Auth::user()->uid,
        'Name'=>$itemSearch
    ]);

    if($check)
    {

       return response([
           "status"=>true,
           "result"=>$check,
           "search"=>true

       ],200);
    }
    else{
       return response([
           "status"=>true,
           "result"=>0,

       ],200);
    }
    }

    public function viewSingleDept($input){
        if($input["searchOption"]=='true') return $this->SearchSingleDept($input);
        $check = DB::select("
        SELECT
            Max(orders.uidUser) as myDeptId,
            MAX(users.name) AS name,
            Max(admnin_records.dettes) AS totDept,
            Max(orders.debt) AS debt
        FROM orders
        INNER JOIN admnin_records ON orders.uidCreator =admnin_records.uid
        INNER JOIN users ON orders.uidUser = users.uid
        WHERE orders.subscriber = :subscriber
            AND orders.uidCreator = :uidCreator
            AND admnin_records.status ='Sales'
            AND admnin_records.subscriber=:adminSubscriber
            AND orders.paidStatus='dettes'
            AND orders.debt>0
            GROUP BY orders.uidUser
            ORDER BY orders.id DESC

    ", [
        'subscriber' => Auth::user()->subscriber,
        'adminSubscriber' => Auth::user()->subscriber,
        'uidCreator' => Auth::user()->uid,
    ]);

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
    }

    public function SearchAllDept($input){
        $item = strtolower($input["name"]);
        $itemSearch='%'.$item.'%';

        $check = DB::select("
        WITH total_dettes AS (
            SELECT
                SUM(admnin_records.dettes) AS totDept
            FROM
                admnin_records
            WHERE
                admnin_records.status = 'Sales'
                AND admnin_records.subscriber = :adminSubscriber1
        )
        SELECT
            MAX(orders.uidUser) AS myDeptId,
            MAX(users.name) AS name,
            MAX(admins.name) AS adminName,
            (SELECT totDept FROM total_dettes) AS totDept,
            MAX(orders.debt) AS debt
        FROM
            orders
        INNER JOIN admnin_records ON orders.uidCreator = admnin_records.uid
        INNER JOIN users ON orders.uidUser = users.uid
        INNER JOIN admins ON orders.uidCreator = admins.uid
        WHERE
            orders.subscriber = :subscriber
            AND admnin_records.status = 'Sales'
            AND admnin_records.subscriber = :adminSubscriber2
            AND orders.paidStatus = 'dettes'
            AND orders.debt > 0
            AND users.name LIKE :Name
        GROUP BY
            orders.uidUser
        ORDER BY
            MAX(orders.id) ASC
    ", [
        'adminSubscriber1' => Auth::user()->subscriber,
        'adminSubscriber2' =>Auth::user()->subscriber,
        'subscriber' =>Auth::user()->subscriber,
        'Name'=>$itemSearch
    ]);


    if($check)
    {

       return response([
           "status"=>true,
           "result"=>$check,
           "search"=>true

       ],200);
    }
    else{
       return response([
           "status"=>true,
           "result"=>0,

       ],200);
    }
    }
    public function viewAllDept($input){
        if($input["searchOption"]=='true') return $this->SearchAllDept($input);
         $check = DB::select("
         WITH total_dettes AS (
             SELECT
                 SUM(admnin_records.dettes) AS totDept
             FROM
                 admnin_records
             WHERE
                 admnin_records.status = 'Sales'
                 AND admnin_records.subscriber = :adminSubscriber1
         )
         SELECT
             MAX(orders.uidUser) AS myDeptId,
             MAX(users.name) AS name,
             MAX(admins.name) AS adminName,
             (SELECT totDept FROM total_dettes) AS totDept,
             sum(orders.debt) AS debt
         FROM
             orders
         INNER JOIN admnin_records ON orders.uidCreator = admnin_records.uid
         INNER JOIN users ON orders.uidUser = users.uid
         INNER JOIN admins ON orders.uidCreator = admins.uid
         WHERE
             orders.subscriber = :subscriber
             AND admnin_records.status = 'Sales'
             AND admnin_records.subscriber = :adminSubscriber2
             AND orders.paidStatus = 'dettes'
             AND orders.debt > 0
         GROUP BY
             orders.uidUser
         ORDER BY
             MAX(orders.id) DESC
     ", [
         'adminSubscriber1' => Auth::user()->subscriber,
         'adminSubscriber2' =>Auth::user()->subscriber,
         'subscriber' =>Auth::user()->subscriber
     ]);


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

     }

    public function viewDeptDetails($input){
   if($input["searchOption"]=='true') return $this->SearchDeptDetails($input);
        $check = DB::select("
        SELECT
            Max(orders.uid) as OrderId,
            MAX(users.name) AS name,
            MAX(admins.CompanyName) AS CompanyName,
            Max(admnin_records.dettes) AS totDept,
            MAX(orders.debt) AS debt
        FROM orders
        INNER JOIN admnin_records ON orders.uidCreator =admnin_records.uid
        INNER JOIN users ON orders.uidUser = users.uid
        INNER JOIN admins ON orders.uidCreator=admins.uid
        WHERE orders.subscriber = :subscriber
            AND orders.uidCreator = :uidCreator
            AND admnin_records.status ='Sales'
            AND admnin_records.subscriber=:adminSubscriber
            AND orders.paidStatus='dettes'
            GROUP BY orders.id
            ORDER BY orders.id DESC

        LIMIT 100
    ", [
        'subscriber' => Auth::user()->subscriber,
        'adminSubscriber' => Auth::user()->subscriber,
        'uidCreator' =>Auth::user()->uid,
    ]);

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

    }
    public function SearchPaidDept($input)
    {
        $item = strtolower($input["name"]);
        $itemSearch='%'.$item.'%';
        $check = DB::select("
        SELECT
            Max(paid_dettes.uid) as OrderId,
            MAX(users.name) AS name,
            Max(admnin_records.safeBalance) AS safeBalance,
            Max(admnin_records.dettes) AS totalDebt,
            MAX(paid_dettes.amount) AS amount,
            MAX(admins.name) AS Recipient,
            MAX(paid_dettes.paidStatus) as paidStatus
        FROM paid_dettes
        INNER JOIN admnin_records ON paid_dettes.uidReceiver=admnin_records.uid
        INNER JOIN users ON paid_dettes.uidUser = users.uid
        INNER JOIN admins ON paid_dettes.uidCreator = admins.uid
        WHERE paid_dettes.subscriber =:subscriber
            AND paid_dettes.uidReceiver=:uidReceiver
            AND admnin_records.status='Sales'
            AND admnin_records.subscriber=:adminSubscriber
            AND users.name LIKE :Name
            GROUP BY paid_dettes.id
            ORDER BY paid_dettes.id DESC

        LIMIT 10
    ", [
        'subscriber'=>Auth::user()->subscriber,
        'adminSubscriber'=>Auth::user()->subscriber,
        'uidReceiver'=>Auth::user()->uid,
        'Name'=>$itemSearch
    ]);


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
    }
    public function viewPaidDept($input){//view Paid means is to view all whether owner received or not
     if($input["searchOption"]=='true') return $this->SearchPaidDept($input);
        $check = DB::select("
        SELECT
            Max(paid_dettes.uid) as OrderId,
            MAX(users.name) AS name,
            Max(admnin_records.safeBalance) AS safeBalance,
            Max(admnin_records.dettes) AS totalDebt,
            MAX(paid_dettes.amount) AS amount,
            MAX(admins.name) AS Recipient,
            MAX(paid_dettes.paidStatus) as paidStatus
        FROM paid_dettes
        INNER JOIN admnin_records ON paid_dettes.uidReceiver=admnin_records.uid
        INNER JOIN users ON paid_dettes.uidUser = users.uid
        INNER JOIN admins ON paid_dettes.uidCreator = admins.uid
        WHERE paid_dettes.subscriber =:subscriber
            AND paid_dettes.uidReceiver=:uidReceiver
            AND admnin_records.status='Sales'
            AND admnin_records.subscriber=:adminSubscriber
            GROUP BY paid_dettes.id
            ORDER BY paid_dettes.id DESC

        LIMIT 100
    ", [
        'subscriber'=>Auth::user()->subscriber,
        'adminSubscriber'=>Auth::user()->subscriber,
        'uidReceiver'=>Auth::user()->uid,
    ]);


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

    }
    public function SearchSafeBalance($input)
    {
        $item = strtolower($input["name"]);
        $itemSearch='%'.$item.'%';
        $check = DB::select("
        SELECT
            Max(paid_dettes.uidCreator) as recipientId,
            Max(admnin_records.safeBalance) AS safeBalance,
            sum(paid_dettes.safeAmount) AS amount,
            MAX(admins.name) AS Recipient,
            MAX(paid_dettes.paidStatus) as paidStatus
        FROM paid_dettes
        INNER JOIN admnin_records ON paid_dettes.uidReceiver=admnin_records.uid
        INNER JOIN admins ON paid_dettes.uidCreator = admins.uid
        WHERE paid_dettes.subscriber =:subscriber
            AND paid_dettes.safeAmount>0
            AND paid_dettes.uidReceiver=:uidReceiver
            AND admnin_records.status='Sales'
            AND admnin_records.subscriber=:adminSubscriber
            AND paid_dettes.paidStatus='PaidAdminNotReceived'
            AND admins.name LIKE :Name
            GROUP BY paid_dettes.uidCreator
            ORDER BY paid_dettes.id DESC


    ", [
        'subscriber'=>Auth::user()->subscriber,
        'adminSubscriber'=>Auth::user()->subscriber,
        'uidReceiver'=>Auth::user()->uid,
        'Name'=>$itemSearch

    ]);

    if($check)
    {

       return response([
           "status"=>true,
           "result"=>$check,
           "uid"=>Auth::user()->uid

       ],200);
    }
    else{
       return response([
           "status"=>true,
           "result"=>0,

       ],200);
    }
    }
    public function viewSafeBalance($input){//to check admin who received my Amount
        if($input["searchOption"]=='true') return $this->SearchSafeBalance($input);
        $check = DB::select("
        SELECT
            Max(paid_dettes.uidCreator) as recipientId,
            Max(admnin_records.safeBalance) AS safeBalance,
            sum(paid_dettes.safeAmount) AS amount,
            MAX(admins.name) AS Recipient,
            MAX(paid_dettes.paidStatus) as paidStatus
        FROM paid_dettes
        INNER JOIN admnin_records ON paid_dettes.uidReceiver=admnin_records.uid
        INNER JOIN admins ON paid_dettes.uidCreator = admins.uid
        WHERE paid_dettes.subscriber =:subscriber
            AND paid_dettes.safeAmount>0
            AND paid_dettes.uidReceiver=:uidReceiver
            AND admnin_records.status='Sales'
            AND admnin_records.subscriber=:adminSubscriber
            AND paid_dettes.paidStatus='PaidAdminNotReceived'

            GROUP BY paid_dettes.uidCreator
            ORDER BY paid_dettes.id DESC


    ", [
        'subscriber'=>Auth::user()->subscriber,
        'adminSubscriber'=>Auth::user()->subscriber,
        'uidReceiver'=>Auth::user()->uid,

    ]);

    if($check)
    {

       return response([
           "status"=>true,
           "result"=>$check,
           "uid"=>Auth::user()->uid

       ],200);
    }
    else{
       return response([
           "status"=>true,
           "result"=>0,

       ],200);
    }
    }
    public function SearchBorrowBalance($input){
        $item = strtolower($input["name"]);
        $itemSearch='%'.$item.'%';
        $check = DB::select("
        SELECT
        Max(paid_dettes.uidReceiver) as OwnerDept,

            Max(admnin_records.borrowBalance) AS borrowBalance,
            sum(paid_dettes.safeAmount) AS amount,
            MAX(admins.name) AS AmountOwner,
            MAX(paid_dettes.paidStatus) as paidStatus
        FROM paid_dettes
        INNER JOIN admnin_records ON paid_dettes.uidCreator=admnin_records.uid
        INNER JOIN admins ON paid_dettes.uidReceiver = admins.uid
        WHERE paid_dettes.subscriber =:subscriber
           AND paid_dettes.safeAmount>0
            AND paid_dettes.uidCreator=:uidCreator
            AND admnin_records.status='Sales'
            AND admnin_records.subscriber=:adminSubscriber
            AND paid_dettes.paidStatus='PaidAdminNotReceived'
            AND admins.name LIKE :Name
            GROUP BY paid_dettes.uidReceiver
            ORDER BY paid_dettes.id DESC


    ", [
        'subscriber'=>Auth::user()->subscriber,
        'adminSubscriber'=>Auth::user()->subscriber,
        'uidCreator'=>Auth::user()->uid,
        'Name'=>$itemSearch
    ]);
    if($check)
    {

       return response([
           "status"=>true,
           "result"=>$check,
           "uid"=>Auth::user()->uid

       ],200);
    }
    else{
       return response([
           "status"=>true,
           "result"=>0,

       ],200);
    }
    }
    public function viewBorrowBalance($input){ //to check Money of Others I am having
        if($input["searchOption"]=='true') return $this->SearchBorrowBalance($input);
        $check = DB::select("
        SELECT
        Max(paid_dettes.uidReceiver) as OwnerDept,

            Max(admnin_records.borrowBalance) AS borrowBalance,
            sum(paid_dettes.safeAmount) AS amount,
            MAX(admins.name) AS AmountOwner,
            MAX(paid_dettes.paidStatus) as paidStatus
        FROM paid_dettes
        INNER JOIN admnin_records ON paid_dettes.uidCreator=admnin_records.uid
        INNER JOIN admins ON paid_dettes.uidReceiver = admins.uid
        WHERE paid_dettes.subscriber =:subscriber
           AND paid_dettes.safeAmount>0
            AND paid_dettes.uidCreator=:uidCreator
            AND admnin_records.status='Sales'
            AND admnin_records.subscriber=:adminSubscriber
            AND paid_dettes.paidStatus='PaidAdminNotReceived'
            GROUP BY paid_dettes.uidReceiver
            ORDER BY paid_dettes.id DESC


    ", [
        'subscriber'=>Auth::user()->subscriber,
        'adminSubscriber'=>Auth::user()->subscriber,
        'uidCreator'=>Auth::user()->uid
    ]);
    if($check)
    {

       return response([
           "status"=>true,
           "result"=>$check,
           "uid"=>Auth::user()->uid

       ],200);
    }
    else{
       return response([
           "status"=>true,
           "result"=>0,

       ],200);
    }
    }


    public function viewSafeBorrow($input){
        if(strtolower($input["isSafe"])=='true')
        {
            return $this->viewSafeBalById($input);
        }
        else{
            return $this->viewBorrowBalById($input);
        }
    }
    public function SearchNameSafeBal($input){
        $item = strtolower($input["name"]);
        $itemSearch='%'.$item.'%';
        $check = DB::select("
        SELECT
            Max(paid_dettes.uidCreator) as recipientId,
            MAX(users.name) AS name,
            Max(admnin_records.safeBalance) AS safeBalance,
            Max(paid_dettes.created_at) AS created_at,
            Max(paid_dettes.safeAmount) AS amount,
            MAX(admins.name) AS Recipient,
            MAX(paid_dettes.paidStatus) as paidStatus
        FROM paid_dettes
        INNER JOIN admnin_records ON paid_dettes.uidReceiver=admnin_records.uid
        INNER JOIN users ON paid_dettes.uidUser = users.uid
        INNER JOIN admins ON  admins.uid=:uidCreator
        WHERE paid_dettes.subscriber =:subscriber
            AND paid_dettes.safeAmount>0
            AND paid_dettes.uidCreator=:uidBorrower
            AND paid_dettes.uidReceiver=:uidReceiver
            AND admnin_records.status='Sales'
            AND admnin_records.subscriber=:adminSubscriber
            AND paid_dettes.paidStatus='PaidAdminNotReceived'
            AND users.name LIKE :name

            GROUP BY paid_dettes.id

            Limit 10


    ", [
        'subscriber'=>Auth::user()->subscriber,
        'adminSubscriber'=>Auth::user()->subscriber,
        'uidReceiver'=>Auth::user()->uid,
        'uidCreator'=>$input['uid'],
        'uidBorrower'=>$input['uid'],
        'name'=>$itemSearch

    ]);

    if($check)
    {

       return response([
           "status"=>true,
           "result"=>$check,
           "uid"=>Auth::user()->uid

       ],200);
    }
    else{
       return response([
           "status"=>true,
           "result"=>0,

       ],200);
    }

    }
    public function viewSafeBalById($input){//to check admin who received my Amount
        if($input["searchOption"]=='true') return $this->SearchNameSafeBal($input);
        $check = DB::select("
        SELECT
            Max(paid_dettes.uidCreator) as recipientId,
            MAX(users.name) AS name,
            Max(admnin_records.safeBalance) AS safeBalance,
            Max(paid_dettes.created_at) AS created_at,
            Max(paid_dettes.safeAmount) AS amount,
            MAX(admins.name) AS Recipient,
            MAX(paid_dettes.paidStatus) as paidStatus
        FROM paid_dettes
        INNER JOIN admnin_records ON paid_dettes.uidReceiver=admnin_records.uid
        INNER JOIN users ON paid_dettes.uidUser = users.uid
        INNER JOIN admins ON  admins.uid=:uidCreator
        WHERE paid_dettes.subscriber =:subscriber
            AND paid_dettes.safeAmount>0
            AND paid_dettes.uidCreator=:uidBorrower
            AND paid_dettes.uidReceiver=:uidReceiver
            AND admnin_records.status='Sales'
            AND admnin_records.subscriber=:adminSubscriber
            AND paid_dettes.paidStatus='PaidAdminNotReceived'

            GROUP BY paid_dettes.id
            ORDER BY paid_dettes.id DESC


    ", [
        'subscriber'=>Auth::user()->subscriber,
        'adminSubscriber'=>Auth::user()->subscriber,
        'uidReceiver'=>Auth::user()->uid,
        'uidCreator'=>$input['uid'],
        'uidBorrower'=>$input['uid']

    ]);

    if($check)
    {

       return response([
           "status"=>true,
           "result"=>$check,
           "uid"=>Auth::user()->uid

       ],200);
    }
    else{
       return response([
           "status"=>true,
           "result"=>0,

       ],200);
    }
    }
    public function SearchBorrowBal($input){
        $item = strtolower($input["name"]);
        $itemSearch='%'.$item.'%';
        $check = DB::select("
        SELECT
        Max(paid_dettes.uidReceiver) as OwnerDept,
            MAX(users.name) AS name,
            Max(admnin_records.borrowBalance) AS borrowBalance,
            Max(paid_dettes.safeAmount) AS amount,
            Max(paid_dettes.created_at) AS created_at,
            MAX(admins.name) AS AmountOwner,
            MAX(paid_dettes.paidStatus) as paidStatus
        FROM paid_dettes
        INNER JOIN admnin_records ON paid_dettes.uidCreator=admnin_records.uid
        INNER JOIN users ON paid_dettes.uidUser = users.uid
        INNER JOIN admins ON admins.uid= :uidReceiver
        WHERE paid_dettes.subscriber =:subscriber
           AND paid_dettes.safeAmount>0
            AND paid_dettes.uidCreator=:uidCreator
            AND paid_dettes.uidReceiver=:uidOwnerDept
            AND admnin_records.status='Sales'
            AND admnin_records.subscriber=:adminSubscriber
            AND paid_dettes.paidStatus='PaidAdminNotReceived'
            AND users.name LIKE :name
            GROUP BY paid_dettes.id

            Limit 10


    ", [
        'subscriber'=>Auth::user()->subscriber,
        'adminSubscriber'=>Auth::user()->subscriber,
        'uidCreator'=>Auth::user()->uid,
        'uidReceiver'=>$input['uid'],
        'uidOwnerDept'=>$input['uid'],
        'name'=>$itemSearch

    ]);
    if($check)
    {

       return response([
           "status"=>true,
           "result"=>$check,
           "uid"=>Auth::user()->uid

       ],200);
    }
    else{
       return response([
           "status"=>true,
           "result"=>0,

       ],200);
    }
    }
    public function viewBorrowBalById($input){ //to check Money of Others I am having
        if($input["searchOption"]=='true') return $this->SearchBorrowBal($input);
        $check = DB::select("
        SELECT
        Max(paid_dettes.uidReceiver) as OwnerDept,
            MAX(users.name) AS name,
            Max(admnin_records.borrowBalance) AS borrowBalance,
            Max(paid_dettes.safeAmount) AS amount,
            Max(paid_dettes.created_at) AS created_at,
            MAX(admins.name) AS AmountOwner,
            MAX(paid_dettes.paidStatus) as paidStatus
        FROM paid_dettes
        INNER JOIN admnin_records ON paid_dettes.uidCreator=admnin_records.uid
        INNER JOIN users ON paid_dettes.uidUser = users.uid
        INNER JOIN admins ON admins.uid= :uidReceiver
        WHERE paid_dettes.subscriber =:subscriber
           AND paid_dettes.safeAmount>0
            AND paid_dettes.uidCreator=:uidCreator
            AND paid_dettes.uidReceiver=:uidOwnerDept
            AND admnin_records.status='Sales'
            AND admnin_records.subscriber=:adminSubscriber
            AND paid_dettes.paidStatus='PaidAdminNotReceived'
            GROUP BY paid_dettes.id
            ORDER BY paid_dettes.id DESC


    ", [
        'subscriber'=>Auth::user()->subscriber,
        'adminSubscriber'=>Auth::user()->subscriber,
        'uidCreator'=>Auth::user()->uid,
        'uidReceiver'=>$input['uid'],
        'uidOwnerDept'=>$input['uid']

    ]);
    if($check)
    {

       return response([
           "status"=>true,
           "result"=>$check,
           "uid"=>Auth::user()->uid

       ],200);
    }
    else{
       return response([
           "status"=>true,
           "result"=>0,

       ],200);
    }
    }


    public function OrderViewCount($input){
        try {

            try {
                $check = DB::select("
                SELECT
                   orderhistories.uid as OrderId,
                    MAX(users.name) AS name,
                    MAX(1) AS hideAddCart,
                    MAX(admins.name) AS adminName,
                    MAX(orderhistories.created_at) AS created_at,

                    SUM(orderhistories.qty) AS totalQty,
                    SUM(orderhistories.total) AS totalAmount,
                    SUM(orderhistories.qty_count) AS totalCount
                FROM orderhistories

                INNER JOIN users ON orderhistories.userid = users.uid
                INNER JOIN admins ON orderhistories.order_creator=admins.uid
                WHERE orderhistories.subscriber=:subscriber
                    AND orderhistories.paidStatus='checked'
                    AND orderhistories.status ='Open'
                GROUP BY orderhistories.uid
                ORDER BY orderhistories.id DESC

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
                //$check["hideAddCart"]=true;
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
    public function OrderViewByUid($input){
        try {

            try {
                $check = DB::select("
                SELECT

                    MAX(orderhistories.uid) AS uid,
                    MAX(orderhistories.description) AS commentData,
                    MAX(1) AS hideAddCart,
                    MAX(1) AS currentQty,
                    orderhistories.productCode,
                    MAX(products.productName) AS productName,
                    MAX(orderhistories.price) AS price,
                    MAX(products.pcs) AS pcs,
                    SUM(orderhistories.qty) AS totalQty,
                    SUM(orderhistories.total) AS totalAmount,
                    SUM(orderhistories.qty_count) AS totalCount
                FROM orderhistories
                INNER JOIN products ON orderhistories.productCode = products.productCode

                WHERE orderhistories.uid =:orderId
                    AND orderhistories.subscriber = :subscriber
                    AND orderhistories.paidStatus='checked'
                    AND orderhistories.status ='Open'

                GROUP BY orderhistories.productCode order by orderhistories.id desc
                LIMIT 25
            ", [

                'orderId' =>$input["orderId"],
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
    public function StockViewDeliver($input){
        $searchOption=($input["productExist"]=='true')?$input["productExist"]:"false";
        $searchQuery=(object)array(
            "true"=>array(
             "DownQuerySearch"=>"AND delivers.productCode=:productCode",
             "paramSearch"=>array(
                "uid" =>$input['uid'],
                "productCode" =>$input['productCode'],
                "uidTransport"=>'uidTransport'
             ),
             "groupByLimit"=>"GROUP BY orders.id
           LIMIT 10"

            ),
            "false"=>array(
             "DownQuerySearch"=>"",
             "paramSearch"=>array(
                "uid" =>$input['uid'],
              "uidTransport" => 'uidTransport'

             ),
             "groupByLimit"=>"GROUP BY orders.id
             ORDER BY orders.id DESC
           LIMIT 100"
            ),
          );
    $DownQuerySearch=$searchQuery->{$searchOption}["DownQuerySearch"];
    $paramSearch=$searchQuery->{$searchOption}["paramSearch"];

       $check = DB::select("SELECT
        MAX(delivers.uid) AS uid,
        MAX(delivers.productCode) AS productCode,
        MAX(delivers.qty_Transport) AS qty,
        MAX(delivers.created_at) AS created_at,
        MAX(admins.name) AS adminName,
        MAX(users.name) AS userName
    FROM delivers
    INNER JOIN admins ON delivers.stockDeliver = admins.uid
    INNER JOIN users ON delivers.uidTransport = users.uid
    WHERE
        delivers.uid=:uid
        $DownQuerySearch
        AND delivers.uidTransport!=:uidTransport
    GROUP BY delivers.id
    ORDER BY delivers.id DESC
    LIMIT 25",
    $paramSearch);
        if($check){
            return response([
                "status"=>true,
                "result"=>$check,

            ],200);
        }
        else{
            return response([
                "status"=>false,
                "result"=>0,

            ],200);
        }
    }
    public function StockCountEdit($input)
    {

        $check=DB::select("select *from delivers where id=:id and uid=:uid and productCode=:productCode and subscriber=:subscriber limit 1",[
            "id"=>$input['id'],
            "uid"=>$input['uid'],
            "productCode"=>$input['productCode'],
            "subscriber"=>Auth::user()->subscriber
        ]);


        if($check)
        {
            $input["balance"]=(-$check[0]->amount+$input['amount']);
            $json_array=[
                "id"=>$check[0]->id,
                "uid"=>$check[0]->uid,
                "productCode"=>$check[0]->productCode,
                "prev_uidTransport"=>$check[0]->uidTransport,
                "prev_qty_Transport"=>$check[0]->qty_Transport,
                "StockName"=>$check[0]->StockName,
                "prev_stockDeliver"=>$check[0]->stockDeliver,
                "prev_commentData"=>$check[0]->commentData,
                "current_commentData"=>$input['commentData']??'none',
                "current__created_at"=>$check[0]->created_at,
                "current__updated_at"=>$check[0]->updated_at,
                "stockDeliver"=>$input['stockDeliver'],
                "updated_at"=>$this->today

             ];

             $data=[
                "tableName"=>"delivers",
                "action"=>"StockCountEdit",
                'tempData'=>json_encode($json_array),
                'status'=>'edituidTransportDeliver'
             ];


           if($this->createBackupAction($data))
           {

            $check=DB::update("update delivers set uidTransport=:uidTransport where id=:id and subscriber=:subscriber limit 1",[
                "id"=>$input["id"],
                "subscriber"=>Auth::user()->subscriber
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
    }
    public function StockCount($input){//count when product is out of stocks



        try {
            $check=DB::transaction(function () use ($input) {//

                $uidTransport=($input['uidTransport']==='UidTransport')?Auth::user()->uid:$input['uidTransport'];//ubitwaye
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
                    DB::table("delivers")
                       ->insert([
                        "uid"=>$uid,
                        "productCode"=>$productCode,
                        "uidTransport"=>$uidTransport,
                        "qty_Transport"=>$qty_Transport,
                        "StockName"=>$stockName,
                        "subscriber"=>Auth::user()->subscriber,
                        "stockDeliver"=>$stockdeliver,
                        "commentData"=>$comment,
                        "created_at"=>$this->today,
                        "updated_at"=>$this->today

                       ]);

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

           qty_count='$remaining',
           ref='uidTransport'
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
                "qty_send"=>$input['qty_Transport']





                ],200);

        } catch (\Exception $e) {
            DB::rollback();
            // throw $e;
             return response()->json(['error' => 'An error occurred',
         'errorPrint'=>$e->getMessage(),"errorCode"=>$e->getLine()], 500); // Return an error JSON response
        }




    }

    public function repaidBack($input){//Admin Paid Another Admin because he has received amount that is not his Amount

        try{

            $checkData=DB::transaction(function () use ($input) {
            $amount=$input['amount'];


            $checkInData = DB::select("
            SELECT SUM(safeAmount) AS total_debt
            FROM paid_dettes
            WHERE uidCreator = :uidCreator1 AND uidReceiver = :uidReceiver1 and paidStatus=:paidStatus1 AND subscriber = :subscriber AND safeAmount != '0'
            HAVING total_debt >= :sumDebt
        ", [
            'uidCreator1' => Auth::user()->uid,
            'uidReceiver1' => $input['uidReceiver'],
            'paidStatus1'=>'PaidAdminNotReceived',
            'subscriber' => Auth::user()->subscriber,
            'sumDebt' => $input['amount']
        ]);


        if($checkInData){
//code

 DB::select("SET @requested_qty=?",[$amount]);
        $data=DB::select("SELECT
        id,
        uid,
        safeAmount AS prevSafeAmount,
        uidReceiver,
        uidCreator,
        systemUid,
        CASE
            WHEN @requested_qty >=safeAmount THEN  safeAmount
            ELSE @requested_qty
        END AS safeAmount,
        CASE
            WHEN @requested_qty >= safeAmount THEN 0
            ELSE @requested_qty - safeAmount
        END AS remaining,
        CASE
            WHEN @requested_qty >=safeAmount THEN 'paidReceived'
            ELSE 'PaidAdminNotReceived'
        END AS new_status,


        @requested_qty := GREATEST(@requested_qty-safeAmount, 0) AS updated_requested_qty

    FROM
        paid_dettes
    WHERE
    uidCreator=:uidCreator AND
    uidReceiver=:uidReceiver AND
       subscriber=:subscriber AND
       paidStatus='PaidAdminNotReceived' AND

        safeAmount != 0 AND
        @requested_qty > 0
    ORDER BY
        id",array(
           "uidCreator"=>Auth::user()->uid,
           "uidReceiver"=>$input['uidReceiver'],
           "subscriber"=>Auth::user()->subscriber
        ));
        if($data)
        {
            $uid="PID"."_".Str::random(2).""."_".date(time());
            $check1=DB::table("repaid_users")
            ->insert([
                "uid"=>$uid,//uid of paid
                "uidPaid"=>Auth::user()->uid,//who paid borrower(ni Admin uri kwishyura ideni)
                "uidReceiver"=>$input['uidReceiver'],//Owner of Debt
                "subscriber"=>Auth::user()->subscriber,
                "amount"=>$input['amount'],
                "systemUid"=>$input['systemUid']??'PointSales1',
                "status"=>'Paid',
                "purpose"=>$input['purpose']??'none',
                "commentData"=>$input['commentData']??'none',
                "created_at"=>$this->today

            ]);
            if($check1)
            {
                DB::update("update admnin_records set borrowBalance=borrowBalance-:amount where uid=:uid and status='Sales' limit 1",[
                    "uid"=>Auth::user()->uid,
                    "amount"=>$input['amount'],

                   ]);
                   DB::update("update admnin_records set safeBalance=safeBalance-:amount where uid=:uid and status='Sales' limit 1",[
                    "uid"=>$input['uidReceiver'],
                    "amount"=>$input['amount'],

                   ]);
                   $dataLimit=count($data);
                   for($i=0;$i<$dataLimit;$i++)
                   {
                    $debtRemain=abs($data[$i]->remaining);
                    $id=$data[$i]->id;
                    $status=$data[$i]->new_status;

                    DB::update("UPDATE paid_dettes
                    SET safeAmount = :debtRemain,
                        paidStatus = :status
                    WHERE id = :id
                        AND subscriber = :subscriber
                    LIMIT :limitData",
                    [
                        "debtRemain"=>$debtRemain,
                        "status"=>$status,
                        "id"=>$id,
                        "subscriber"=>Auth::user()->subscriber,
                        "limitData"=>$dataLimit,
                    ]
       );
                   }

                   return array(
    //"data"=>$checkData[0]->total_debt,
    "status"=>true,
    "checkData"=>$checkInData,
    "message"=>"Payment Received"


 );

            }

        }
        else{

        }
//End code


   //

        }
        else{
            return array(
                "status"=>false,
                "checkData"=>$checkInData,
                "message"=>"Please Try Again, amount Paid is greater that debt client has ,contact system Admin"


             );
        }



        });

        return response($checkData,200);
        //return response()->json(['status'=>true,'message' => 'Payment Received',"result"=>$checkData], 200);

            } catch (\Exception $e) {
                     DB::rollback();
                    // throw $e;
                     return response()->json(['error' => 'An error occurred',
                 'errorPrint'=>$e->getMessage(),"errorCode"=>$e->getLine()], 500); // Return an error JSON response
                 }

    }
    public function confirmRepaidBack($input){

        $check=DB::update("update repaid_users set status=:status,receiverComment=:receiverComment,signature=:signature,updated_at=:updated_at where uid=:uid and uidReceiver=:uidReceiver and subscriber=:subscriber limit 1",array(
        "uid"=>$input['uid'],//paid ID
        "subscriber"=>Auth::user()->subscriber,
        "status"=>"PaidReceived",
        "uidReceiver"=>Auth::user()->uid,
        "signature"=>$input['signature']??'1',
        "receiverComment"=>$input['receiverComment']??'Received',
        "updated_at"=>$this->today,
       ));
       if($check){
        return response([
            "status"=>true,
            "message"=>"Received this Amount"
             ],200);
     }
     else{
        return response([
            "status"=>false,
            "message"=>"Something Wrong "
             ],200);
     }

    }
    public function viewRepay($input){
        if(strtolower($input["IsReceiver"])=='true')
        {
            return $this->receivedHistory($input);//owner to see Payment History Safe
        }
        else{
            return $this->repaidHistory($input);//Who paid Means Borrower
        }
    }
    public function searchReceivedHistory($input){
        $item = strtolower($input["name"]);
        $itemSearch='%'.$item.'%';
        $check=DB::select("
        SELECT
            Max(repaid_users.uid) as uid,
            Max(repaid_users.status) as status,
            Max(repaid_users.amount) as amount,
            Max(repaid_users.created_at) as created_at,
            Max(repaid_users.commentData) as commentData,
            MAX(admins.name) AS borrowerName

        FROM repaid_users

        INNER JOIN admins ON repaid_users.uidPaid=admins.uid
        WHERE repaid_users.uidReceiver=:uidReceiver
             AND repaid_users.uidPaid=:uidPaid
            AND repaid_users.subscriber =:subscriber
            AND admins.name LIKE :name

            GROUP BY repaid_users.id
            LIMIT 10


    ", [
        'subscriber'=>Auth::user()->subscriber,

        'uidPaid'=>$input['uid'],
        'uidReceiver'=>Auth::user()->uid,
        'name'=>$itemSearch
    ]);

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
    }
    public function receivedHistory($input)
    {
       if($input["searchOption"]=='true') return $this->searchReceivedHistory($input);
        $check=DB::select("
        SELECT
            Max(repaid_users.uid) as uid,
            Max(repaid_users.status) as status,
            Max(repaid_users.amount) as amount,
            Max(repaid_users.created_at) as created_at,
            Max(repaid_users.commentData) as commentData,
            MAX(admins.name) AS borrowerName

        FROM repaid_users

        INNER JOIN admins ON repaid_users.uidPaid=admins.uid
        WHERE repaid_users.uidReceiver=:uidReceiver
        AND repaid_users.uidPaid=:uidPaid
            AND repaid_users.subscriber =:subscriber

            GROUP BY repaid_users.id
            ORDER BY repaid_users.id DESC


    ", [
        'subscriber'=>Auth::user()->subscriber,
        'uidPaid'=>$input['uid'],

        'uidReceiver'=>Auth::user()->uid
    ]);

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
           "result"=>0,

       ],200);
    }
    }
    public function SearchrepaidHistory($input){
        $item = strtolower($input["name"]);
        $itemSearch='%'.$item.'%';
        $check=DB::select("
        SELECT
            Max(repaid_users.uid) as uid,
            Max(repaid_users.status) as status,
            Max(repaid_users.amount) as amount,
            Max(repaid_users.updated_at) as updated_at,
            Max(repaid_users.commentData) as commentData,
            MAX(admins.name) AS OwnerDeptName

        FROM repaid_users

        INNER JOIN admins ON repaid_users.uidReceiver=admins.uid
        WHERE repaid_users.uidPaid=:uidPaid
        AND repaid_users.uidReceiver=:uidReceiver
            AND repaid_users.subscriber =:subscriber
            AND admins.name LIKE :name

            GROUP BY repaid_users.id

            LIMIT 10


    ", [
        'subscriber'=>Auth::user()->subscriber,

        'uidPaid'=>Auth::user()->uid,
        'uidReceiver'=>$input['uid'],
        'name'=>$itemSearch
    ]);

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
           "result"=>0,

       ],200);
    }
    }
    public function repaidHistory($input){
        if($input["searchOption"]=='true') return $this->SearchrepaidHistory($input);
        $check=DB::select("
        SELECT
            Max(repaid_users.uid) as uid,
            Max(repaid_users.status) as status,
            Max(repaid_users.amount) as amount,
            Max(repaid_users.updated_at) as updated_at,
            Max(repaid_users.commentData) as commentData,
            MAX(admins.name) AS OwnerDeptName

        FROM repaid_users

        INNER JOIN admins ON repaid_users.uidReceiver=admins.uid
        WHERE repaid_users.uidPaid=:uidPaid
            AND repaid_users.uidReceiver=:uidReceiver
            AND repaid_users.subscriber =:subscriber

            GROUP BY repaid_users.id
            ORDER BY repaid_users.id DESC


    ", [
        'subscriber'=>Auth::user()->subscriber,

        'uidPaid'=>Auth::user()->uid,
        'uidReceiver'=>$input['uid']
    ]);

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
           "result"=>0,

       ],200);
    }
    }
    public function addSpending($input){
        if(strtolower($input["options"])=='others')
        {
            return $this->add_OtherSpending($input);
        }
        else{
            return $this->add_SafariSpending($input);
        }
    }
    public function add_OtherSpending($input){

        try{


        $check=DB::transaction(function () use ($input) {
            $uidUser=Auth::user()->uid;

            $uid="SUID"."_".Str::random(2).""."_".date(time());//SUID means Spend UID
            $check=DB::table("depenses")
            ->insert([
                "uid"=>$uid,
                "uidUser"=>$input['uidUser']??Auth::user()->uid,
                "amount"=>$input['balance'],
                "uidCreator"=>Auth::user()->uid,

                "status"=>$input['status'],
                "systemUid"=>$input["systemUid"],
                "subscriber"=>Auth::user()->subscriber,

                "purpose"=>$input['purpose']??'none',
                "commentData"=>$input['commentData'],
                "created_at"=>$this->today

            ]);

        if($check){

           $check=DB::update("update admnin_records set balance=balance+:balance where uid=:uid and status=:status and subscriber=:subscriber and systemUid=:systemUid limit 1",array(
            "balance"=>$input['balance'],
            "uid"=>$uidUser,
            "status"=>$input["status"],

            "systemUid"=>$input["systemUid"],
            "subscriber"=>Auth::user()->subscriber
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
                    "systemUid"=>$input["systemUid"],
                    "status"=>$input["status"],
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
    public function updateSpending($input){ //not done
       // DB::beginTransaction();
        try {
            $check=DB::select("select *from depenses where uid=:uid  and subscriber=:subscriber limit 1",[
                "uid"=>$input['uid'],
                "subscriber"=>Auth::user()->subscriber
            ]);


            if($check)
            {
                $input["balance"]=(-$check[0]->amount+$input['amount']);
                $json_array=[
                    "uid"=>$check[0]->uid,
                    "safariId"=>$check[0]->safariId,
                    "prev_amount"=>$check[0]->amount,
                    "current_amount"=>$input['amount'],
                    "prev_purpose"=>$check[0]->purpose,
                    "current_purpose"=>$input['purpose'],

                    "prev_uidCreator"=>$check[0]->uidCreator,
                    "current_uidCreator"=>Auth::user()->uid,
                    "current__updated_at"=>$check[0]->updated_at,
                    "updated_at"=>$this->today

                 ];

                 $data=[
                    "tableName"=>"products",
                    "action"=>$input['actionStatus'],
                    'tempData'=>json_encode($json_array),
                    'status'=>'edit'
                 ];


               if($this->createBackupAction($data))
               {
                if(strtolower($input["actionStatus"])==strtolower('Edit_otherSpending'))
                {

                    return $this->edit_OtherSpending($input);
                }
                else if(strtolower($input["actionStatus"])==strtolower('Edit_SafariSpending'))
                {

                    return $this->edit_SafariSpending($input);
                }
                else if(strtolower($input["actionStatus"])==strtolower('delete_OtherSpending'))
                {
                    $input["balance"]=(-$check[0]->amount);
                    return $this->delete_OtherSpending($input);
                }
                else{
                    $input["balance"]=(-$check[0]->amount);
                    return $this->delete_SafariSpending($input);
                }

               }
               else{
                return response([
                    "status"=>false,
                    "result"=>$check,

                ],200);
            }


            }

        } catch (\Exception $e) {
            DB::rollback();
            return response()->json([
                'error' => 'An error occurred',
                'errorPrint' => $e->getMessage(),
                'errorCode' => $e->getLine(),
            ], 500);
        }





    }
    public function edit_OtherSpending($input){
        $check=DB::update("update depenses set amount=:amount,purpose=:purpose,commentData=:commentData,updated_at=:updated_at where uid=:uid and uidCreator=:uidCreator  and subscriber=:subscriber  limit 1 ",array(
            "uid"=>$input['uid'],

            "amount"=>$input['amount'],
            "uidCreator"=>Auth::user()->uid,

            "subscriber"=>Auth::user()->subscriber,

            "purpose"=>$input['purpose']??'none',
            "commentData"=>$input['commentData']??'none',
            "updated_at"=>$this->today
           ));
           if($check){
            $check1=DB::update("update admnin_records set balance=balance+:balance where uid=:uid and status=:status and subscriber=:subscriber and systemUid=:systemUid limit 1",array(
                "balance"=>$input['balance'],
                "uid"=>Auth::user()->uid,
                "status"=>"GeneralSpend",

                "systemUid"=>$input["systemUid"]??'PointSales1',
                "subscriber"=>Auth::user()->subscriber
               ));
               if($check1){
                return response([
                    "status"=>true,
                    "result"=>$check1

                ],200);
            }
            else{
                return response([
                    "status"=>false,
                    "result"=>$check1

                ],200);
            }
           }

    }
    public function edit_SafariSpending($input){

        if(($this->updateSafariSpending($input)->original["status"]))
        {
            $check=DB::update("update depenses set amount=:amount,purpose=:purpose,commentData=:commentData,updated_at=:updated_at where uid=:uid and uidCreator=:uidCreator  and subscriber=:subscriber  limit 1 ",array(
                "uid"=>$input['uid'],

                "amount"=>$input['amount'],
                "uidCreator"=>Auth::user()->uid,

               "subscriber"=>Auth::user()->subscriber,

                "purpose"=>$input['purpose']??'none',
                "commentData"=>$input['commentData']??'none',
                "updated_at"=>$this->today
               ));
               if($check){
                return response([
                    "status"=>true,
                    "result"=>$check

                ],200);
            }
            else{
                return response([
                    "status"=>false,
                    "result"=>$check

                ],200);
            }
        }
    }
    public function delete_OtherSpending($input){
        $check=DB::delete("delete From depenses where uid=:uid and subscriber=:subscriber",[
            "uid"=>$input["uid"],
            "subscriber"=>Auth::user()->subscriber
            ]);

           if($check){
            $check1=DB::update("update admnin_records set balance=balance+:balance where uid=:uid and status=:status and subscriber=:subscriber and systemUid=:systemUid limit 1",array(
                "balance"=>$input['balance'],
                "uid"=>Auth::user()->uid,
                "status"=>"GeneralSpend",

                "systemUid"=>$input["systemUid"]??'PointSales1',
                "subscriber"=>Auth::user()->subscriber
               ));
               if($check1){
                return response([
                    "status"=>true,
                    "result"=>$check1

                ],200);
            }
            else{
                return response([
                    "status"=>false,
                    "result"=>$check1

                ],200);
            }
           }
    }
    public function delete_SafariSpending($input){
        if(($this->updateSafariSpending($input)->original["status"]))
        {
            $check=DB::delete("delete from depenses where uid=:uid and subscriber=:subscriber",[
                "uid"=>$input["uid"],
                "subscriber"=>Auth::user()->subscriber
                ]);
                if($check){
                    return response([
                        "status"=>true,
                        "result"=>$check

                    ],200);
                }
                else{
                    return response([
                        "status"=>false,
                        "result"=>$check

                    ],200);
                }
        }

    }
    public function updateSafariSpending($input){
        $stockInterest=$input['safariId']."_"."int";//interest
        $stockDisplay=$input['safariId']."_"."dis";//display Stock

        Cache::put($stockInterest,'',now()->addMinutes(0));//Reset
        Cache::put($stockDisplay,'',now()->addMinutes(0));//Reset
        $check1=DB::update("update safariproducts set TotBuyAmount=TotBuyAmount+:TotBuyAmount,updated_at=:updated_at where safariId=:safariId and status='spendSafaris' and subscriber=:subscriber limit 1",[
            "TotBuyAmount"=>$input['balance'],
            "updated_at"=>$this->today,
            "safariId"=>$input['safariId'],
            "subscriber"=>Auth::user()->subscriber
           ]);
        if($check1){
            return response([
                "status"=>true,
                "result"=>$check1

            ],200);
        }
        else{
            return response([
                "status"=>false,
                "result"=>$check1

            ],200);
        }
    }
    public function SearchSpending($input)
    {
        $item = strtolower($input["name"]);
        $itemSearch='%'.$item.'%';
        $check=DB::select("
        SELECT
            Max(depenses.uid) as spendId,
            MAX(depenses.purpose) AS purpose,
            MAX(depenses.commentData) AS commentData,
            Max(admnin_records.balance) AS totSpending,
            MAX(depenses.amount) AS spending,
            MAX(depenses.created_at) AS created_at

        FROM depenses
        INNER JOIN admnin_records ON depenses.uidCreator=admnin_records.uid
       WHERE depenses.subscriber=:subscriber
            AND depenses.uidCreator=:uidCreator
            AND depenses.status!='spendSafaris'
            AND admnin_records.status ='GeneralSpend'
            AND admnin_records.subscriber=:adminSubscriber
            AND depenses.purpose LIKE :purpose

            GROUP BY depenses.id


        LIMIT 10
    ", [
        'subscriber'=>Auth::user()->subscriber,
        'adminSubscriber'=>Auth::user()->subscriber,
       'uidCreator'=>Auth::user()->uid,
       'purpose'=>$itemSearch
    ]);

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
    }
    public function view_OtherSpending($input){//not Safari Spending
    if($input["searchOption"]=='true') return $this->SearchSpending($input);
        $check=DB::select("
        SELECT
            Max(depenses.uid) as spendId,
            MAX(depenses.purpose) AS purpose,
            MAX(depenses.commentData) AS commentData,
            Max(admnin_records.balance) AS totSpending,
            MAX(depenses.amount) AS spending,
            MAX(depenses.created_at) AS created_at

        FROM depenses
        INNER JOIN admnin_records ON depenses.uidCreator=admnin_records.uid
       WHERE depenses.subscriber=:subscriber
            AND depenses.uidCreator=:uidCreator
            AND depenses.status!='spendSafaris'
            AND admnin_records.status ='GeneralSpend'
            AND admnin_records.subscriber=:adminSubscriber

            GROUP BY depenses.id
            ORDER BY depenses.id DESC

        LIMIT 10
    ", [
        'subscriber'=>Auth::user()->subscriber,
        'adminSubscriber'=>Auth::user()->subscriber,
       'uidCreator'=>Auth::user()->uid,
    ]);

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
    }
    public function viewSpending($input){//General Spending

        if(strtolower($input["options"])=='others')
        {

            return $this->view_OtherSpending($input);
        }
        else{
            return $this->view_SafariSpending($input);
        }
    }


    public function SearchSafariSpending($input){
        $item = strtolower($input["name"]);
        $itemSearch='%'.$item.'%';
        $check=DB::select("
        SELECT
            Max(depenses.uid) as spendId,
            MAX(depenses.purpose) AS purpose,
            MAX(depenses.commentData) AS commentData,
            Max(safariproducts.TotBuyAmount) AS totSpending,
            Max(safariproducts.safariId) AS safariId,
            MAX(depenses.amount) AS spending,
            MAX(depenses.created_at) AS created_at

        FROM depenses
        INNER JOIN safariproducts ON depenses.safariId=safariproducts.safariId
       WHERE depenses.subscriber=:subscriber
            AND safariproducts.status='spendSafaris'
            AND depenses.uidCreator=:uidCreator
            AND depenses.safariId=:safariId
            AND depenses.purpose LIKE :purpose
            GROUP BY depenses.id


        LIMIT 10
    ", [
        'subscriber'=>Auth::user()->subscriber,
        'safariId'=>$input['safariId'],

       'uidCreator'=>Auth::user()->uid,
       'purpose'=>$itemSearch
    ]);

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
    }
    public function view_SafariSpending($input)
    {
        if($input["searchOption"]=='true') return $this->SearchSafariSpending($input);
        $check=DB::select("
        SELECT
            Max(depenses.uid) as spendId,
            MAX(depenses.purpose) AS purpose,
            MAX(depenses.commentData) AS commentData,
            Max(safariproducts.TotBuyAmount) AS totSpending,
            Max(safariproducts.safariId) AS safariId,
            MAX(depenses.amount) AS spending,
            MAX(depenses.created_at) AS created_at

        FROM depenses
        INNER JOIN safariproducts ON depenses.safariId=safariproducts.safariId
       WHERE depenses.subscriber=:subscriber
            AND safariproducts.status='spendSafaris'
            AND depenses.uidCreator=:uidCreator
            AND depenses.safariId=:safariId

            GROUP BY depenses.id
            ORDER BY depenses.id DESC

        LIMIT 10
    ", [
        'subscriber'=>Auth::user()->subscriber,
        'safariId'=>$input['safariId'],
       'uidCreator'=>Auth::user()->uid,
    ]);

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
    }

    public function add_SafariSpending($input){

        try{


        $check=DB::transaction(function () use ($input) {
            $stockInterest=$input['safariId']."_"."int";//interest
            $stockDisplay=$input['safariId']."_"."dis";//display Stock

            Cache::put($stockInterest,'',now()->addMinutes(0));//Reset
            Cache::put($stockDisplay,'',now()->addMinutes(0));//Reset
            $uidUser=Auth::user()->uid;

            $uid="SAFID"."_".Str::random(2).""."_".date(time());//SUID means Spend UID
            $check5=DB::table("depenses")
            ->insert([
                "uid"=>$uid,
                "safariId"=>$input['safariId'],
                "uidUser"=>$input['uidUser']??Auth::user()->uid,
                "amount"=>$input['balance'],
                "uidCreator"=>Auth::user()->uid,

                "status"=>"spendSafaris",
                "systemUid"=>$input["systemUid"]??'PointSales1',
                "subscriber"=>Auth::user()->subscriber,

                "purpose"=>$input['purpose']??'none',
                "commentData"=>$input['commentData']??'none',
                "created_at"=>$this->today

            ]);

        if($check5){

         $check2=DB::update("update safariproducts set TotBuyAmount=TotBuyAmount+:TotBuyAmount,updated_at=:updated_at where safariId=:safariId and status='spendSafaris' and subscriber=:subscriber limit 1",[
            "TotBuyAmount"=>$input['balance'],
            "updated_at"=>$this->today,
            "safariId"=>$input['safariId'],
            "subscriber"=>Auth::user()->subscriber
           ]);

           if($check2){
            return array(
                "status"=>true,
                "safariuid"=>$input["safariId"],
                "safariName"=>$input["safariName"]
            );
           }
           else{
            $check3=DB::table("safariproducts")
            ->insert([
                "safariId"=>$input["safariId"],
                "productCode"=>$uid,//(it may be productCode or uid of spending)
                "price"=>"0",
                "qty"=>"0",
                "totQty"=>"0",
                "TotSoldAmount"=>"0",
                "TotBuyAmount"=>$input['balance'],
                "status"=>"spendSafaris",
                "CommentStatus"=>"SafariSpending",

                "uidCreator"=>Auth::user()->uid,
                "subscriber"=>Auth::user()->subscriber,
                "created_at"=>$this->today,
                "updated_at"=>$this->today
            ]);
            if($check3)
            {

                 return array(
                    "status"=>true,
                    "safariuid"=>$input["safariId"],
                    "safariName"=>$input["safariName"]
                );
            }
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


    return response($check,200);


                } catch (\Exception $e) {
                    DB::rollback();
                   // throw $e;
                    return response()->json(['error' => 'An error occurred',
                'errorPrint'=>$e->getMessage()], 500); // Return an error JSON response
                }
    }
public function addFunding($input){//General Funding

    try{


        $check=DB::transaction(function () use ($input) {
            $uidUser=Auth::user()->uid;

            $uid="SUID"."_".Str::random(2).""."_".date(time());//SUID means Spend UID
            $check=DB::table("depenses")
            ->insert([
                "uid"=>$uid,
                "Funded"=>$input['uidUser']??Auth::user()->uid,
                "amount"=>$input['balance'],
                "uidCreator"=>Auth::user()->uid,

                "status"=>$input['status'],
                "systemUid"=>$input["systemUid"],
                "subscriber"=>Auth::user()->subscriber,

                "purpose"=>$input['purpose']??'none',
                "commentData"=>$input['commentData'],
                "created_at"=>$this->today

            ]);

        if($check){

           $check=DB::update("update admnin_records set balance=balance+:balance where uid=:uid and status=:status and subscriber=:subscriber and systemUid=:systemUid limit 1",array(
            "balance"=>$input['balance'],
            "uid"=>$uidUser,
            "status"=>$input["status"],

            "systemUid"=>$input["systemUid"],
            "subscriber"=>Auth::user()->subscriber
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
                    "systemUid"=>$input["systemUid"],
                    "status"=>$input["status"],
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
public function editFunding($input){

}
public function deleteFunding($input){

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
