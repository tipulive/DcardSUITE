<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/
Route::get('/addData','TransportController@addData')->name('addData');
Route::get('/viewSeat','TransportController@viewSeat')->name('viewSeat');
Route::get('/viewSearchLocation','TransportController@viewSearchLocation')->name('viewSearchLocation');

//Appointment//
Route::post('/ussdView','appointmentController@ussdView')->name('ussdView');
Route::post('/chooseOption','appointmentController@chooseOption')->name('chooseOption');
//Appointment//
//Route::get('/SearchTransport','TransportController@SearchTransport')->name('SearchTransport');

Route::post('/DataUssD','ussdController@DataUssD')->name('DataUssD');
Route::post('/CreateCompany','AdminController@AdminCreateCompany')->name('AdminCreateCompany');
Route::get('/trackNumber','shippingController@trackNumber')->name('trackNumber');

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::get('testSubmitOrder', 'TestController@testSubmitOrder');
Route::post('testPostData', 'TestController@testPostData');
Route::get('testGetData', 'TestController@testGetData');
Route::get('testGetProductSafari', 'TestController@testGetProductSafari');
Route::get('testEditorder', 'TestController@testEditorder');
Route::get('testdisplayCalculate','TestController@testdisplayCalculate');
Route::get('testcalculate','TestController@testcalculate');
Route::get('testPDf', 'TestController@testPDf');

/*test Encryption */

/* Users Authentication*/
Route::post('/UserRegisterEmail','UserController@UserRegisterEmail')->name('UserRegisterEmail');
Route::post('/UserLoginEmail','UserController@UserLoginEmail')->name('UserLoginEmail');


/* others Authentication*/
Route::post('/AdminRegisterEmail','AdminController@AdminRegisterEmail')->name('AdminRegisterEmail');
Route::post('/AdminLoginEmail','AdminController@AdminLoginEmail')->name('AdminLoginEmail');
Route::post('/AdminLoginPhone','AdminController@AdminLoginPhone')->name(' AdminLoginPhone');

//Route::get('/testauth','TestController@testauth')->name('testauth');

Route::middleware('auth:sanctum')->group( function () {//here is to protect multiple route
  /*appointment*/

  Route::get('/loadCode','CompanyController@loadCode')->name('loadCode');

  Route::get('/ussdViewCreate','CompanyController@ussdViewCreate')->name('ussdViewCreate');
  Route::post('/service','CompanyController@service')->name('service');
  Route::get('/service','CompanyController@service')->name('service');
  Route::get('/getCode','CompanyController@getCode')->name('getCode');
  Route::post('/code','CompanyController@code')->name('code');
  Route::get('/applicationAppointment','CompanyController@applicationAppointment')->name('applicationAppointment');//get a
  Route::post('/appointment','CompanyController@appointment')->name('appointment');
  /*appointment*/

    /*Travers */
  Route::get('/viewAllCars','CompanyController@viewAllCars')->name('viewAllCars');
  Route::get('/viewAllLocations','CompanyController@viewAllLocations')->name('viewAllLocations');
  Route::get('/LocationTrip','CompanyController@LocationTrip')->name('LocationTrip');
Route::get('/Cars','CompanyController@Cars')->name('Cars');
  Route::get('/viewAllDashTrip','CompanyController@viewAllDashTrip')->name('viewAllDashTrip');
  Route::get('/viewTravelSales','CompanyController@viewTravelSales')->name('viewTravelSales');
  Route::get('/SearchTransport','CompanyController@SearchTransport')->name('SearchTransport');
  Route::get('/searchLocation','CompanyController@searchLocation')->name('searchLocation');
  Route::post('/BookTicket','CompanyController@BookTicket')->name('BookTicket');
  Route::post('/registerVehicle','CompanyController@registerVehicle')->name('registerVehicle');
  Route::post('/createLocation','CompanyController@createLocation')->name('createLocation');
  Route::post('/addDashboardTrip','CompanyController@addDashboardTrip')->name('addDashboardTrip');
  /*Travers */
    /*shipping */
   Route::get('/searchShipUser','CompanyController@searchShipUser')->name('searchShipUser');
   Route::post('/deleteShipping','CompanyController@deleteShipping')->name('deleteShipping');
   Route::post('/editShipping','CompanyController@editShipping')->name('editShipping');
   Route::get('/shipSearch','CompanyController@shipSearch')->name('shipSearch');
   Route::post('/ShippingCreate','CompanyController@ShippingCreate')->name('ShippingCreate');
   Route::get('/editStatShip','CompanyController@editStatShip')->name('editStatShip');
   Route::get('/viewAllShipping','CompanyController@viewAllShipping')->name('viewAllShipping');
   /*shipping */


    Route::get('/logout','AccountController@logout')->name('logout');

/*AdminData*/
Route::post('upload','StockController@upload');
/*Company*/
Route::post('/utilitySubmitOrder','CompanyController@utilitySubmitOrder')->name('utilitySubmitOrder');
Route::get('/PrintCard','CompanyController@CompanyPrintCard')->name('CompanyPrintCard');
Route::post('/CreateUser','CompanyController@CompanyCreateUser')->name('CompanyCreateUser');
Route::post('/CreateUserAssign','CompanyController@CompanyCreateUserAssign')->name('CompanyCreateUserAssign');
Route::post('/EditUserAssign','CompanyController@CompanyEditUserAssign')->name('CompanyEditUserAssign');
Route::get('/GetNumberDetail','CompanyController@CompanyGetNumberDetail')->name('CompanyGetNumberDetail');
Route::get('/GetCardDetail','CompanyController@CompanyGetCardDetail')->name('CompanyGetCardDetail');
Route::post('/CreateCard','CompanyController@CompanyCreateCard')->name('CompanyCreateCard');
Route::post('/CreateMultipleCard','CompanyController@CompanyCreateMultipleCard')->name('CompanyCreateMultipleCard');
Route::post('/AssignCard','CompanyController@CompanyAssignCard')->name('CompanyAssignCard');
Route::get('/CompanySyncCardDownload','CompanyController@CompanySyncCardDownload')->name('CompanySyncCardDownload');
Route::post('/CompanySyncUpload','CompanyController@CompanySyncUpload')->name('CompanySyncUpload');
Route::post('/CreatePromotionEvent','CompanyController@CompanyCreatePromotionEvent')->name('CompanyCreatePromotionEvent');
Route::post('/EditPromotionEvent','CompanyController@CompanyEditPromotionEvent')->name('CompanyEditPromotionEvent');
Route::get('/GetAllPromotionEvent','CompanyController@CompanyGetAllPromotionEvent')->name('CompanyGetAllPromotionEvent');
Route::get('/ViewAllPromotionEvent','CompanyController@CompanyViewAllPromotionEvent')->name('CompanyViewAllPromotionEvent');
Route::post('/SetPromotionEventStatus','CompanyController@CompanySetPromotionEventStatus')->name('CompanySetPromotionEventStatus');
/*company make user Participate */
Route::post('/ParticipateEvent','CompanyController@CompanyParticipateEvent')->name('CompanyParticipateEvent');
Route::post('/ParticipateEditEvent','CompanyController@CompanyParticipateEditEvent')->name('CompanyParticipateEditEvent');

Route::get('/CountParticipateEvent','CompanyController@CompanyCountParticipateEvent')->name('CompanyCountParticipateEvent');
Route::get('/GetAllParticipateEvent','CompanyController@CompanyGetAllParticipateEvent')->name('CompanyGetAllParticipateEvent');
Route::get('/GetActiveParticipateEvent','CompanyController@CompanyGetActiveParticipateEvent')->name('CompanyGetActiveParticipateEvent');
Route::get('/GetReachedParticipateEvent','CompanyController@CompanyGetReachedParticipateEvent')->name('CompanyGetReachedParticipateEvent');
Route::get('/GetParticipatedHist','CompanyController@CompanyGetParticipatedHist')->name('CompanyGetParticipatedHist');
Route::get('/GetAllParticipatedHist','CompanyController@CompanyGetAllParticipatedHist')->name('CompanyGetAllParticipatedHist');
Route::get('/GetAllParticipate','CompanyController@CompanyGetAllParticipate')->name('CompanyGetAllParticipate');

/*company topup User */

Route::post('/AddBalance','CompanyController@CompanyTopupUser')->name('CompanyTopupUser');
Route::post('/EditBalance','CompanyController@CompanyTopupEditBalance')->name('CompanyTopupEditBalance');
Route::post('/RedeemBalance','CompanyController@CompanyTopupRedeemBalance')->name('CompanyTopupRedeemBalance');
Route::post('/RedeemBonus','CompanyController@CompanyTopupRedeemBonus')->name('CompanyTopupRedeemBonus');
Route::get('/GetCompanyRecord','CompanyController@CompanyTopupGetCompanyRecord')->name('CompanyTopupGetCompanyRecord');
Route::get('/GetBalanceUser','CompanyController@CompanyTopupBalanceUser')->name('CompanyTopupBalanceUser');
Route::get('/GetBalanceHist','CompanyController@CompanyTopupBalanceHistUser')->name('CompanyTopupBalanceHistUser');
Route::get('/GetBalanceHistCreator','CompanyController@CompanyTopupBalanceHistCreator')->name('CompanyTopupBalanceHistCreator');
Route::get('/GetWBalanceHistUser','CompanyController@CompanyTopupWBalanceHistUser')->name('CompanyTopupWBalanceHistUser');
Route::get('/AdminProductComeFrom','CompanyController@AdminProductComeFrom')->name('AdminProductComeFrom');
Route::get('/searchSpendPurpose','CompanyController@searchSpendPurpose')->name('searchSpendPurpose');

/*Quickie Bonus */
Route::post('/SetupQuickBonus','CompanyController@CompanyPartSetupQuickBonus')->name('CompanyPartSetupQuickBonus');
Route::get('/GetAllQuickBonus','CompanyController@CompanyPartGetAllQuickBonus')->name('CompanyPartGetAllQuickBonus');
Route::get('/SearchQuickBonus','CompanyController@CompanyPartSearchQuickBonus')->name('CompanyPartSearchQuickBonus');
Route::get('/SubmitQuickBonus','CompanyController@CompanyPartSubmitQuickBonus')->name('CompanyPartSubmitQuickBonus');
Route::get('/UpdateSubmitQuickBonus','CompanyController@CompanyPartUpdateSubmitQuickBonus')->name('CompanyPartUpdateSubmitQuickBonus');
Route::get('/ConfirmAllSubmitQuickBonus','CompanyController@CompanyPartConfirmAllSubmitQuickBonus')->name('ConfirmAllSubmitQuickBonus');
Route::get('/ConfirmOnlySubmitQuickBonus','CompanyController@CompanyPartConfirmOnlySubmitQuickBonus')->name('ConfirmOnlySubmitQuickBonus');
Route::get('/SearchSubmitQuickBonus','CompanyController@CompanyPartSearchSubmitQuickBonus')->name('CompanyPartSearchSubmitQuickBonus');
Route::get('/GetUidSubmitQuickBonus','CompanyController@CompanyPartGetUidSubmitQuickBonus')->name('CompanyPartGetUidSubmitQuickBonus');
Route::get('/DeleteAllSubmitQuickBonus','CompanyController@CompanyPartDeleteAllSubmitQuickBonus')->name('CompanyPartDeleteAllSubmitQuickBonus');
Route::get('/DeleteOnlySubmitQuickBonus','CompanyController@CompanyPartDeleteOnlySubmitQuickBonus')->name('CompanyPartDeleteOnlySubmitQuickBonus');
Route::get('/GetAllSubmitQuickBonus','CompanyController@CompanyPartGetAllSubmitQuickBonus')->name('CompanyPartGetAllSubmitQuickBonus');
Route::get('/CheckQuickBonus','CompanyController@CompanyPartCheckQuickBonus')->name('CompanyPartCheckQuickBonus');
/*new Safari Stocks Code */
Route::get('/GetSafaris','CompanyController@GetSafaris')->name('GetSafaris');
Route::post('/CreateSafari','CompanyController@CreateSafari')->name('CreateSafari');
Route::post('/EditSafari','CompanyController@EditSafari')->name('EditSafari');
Route::post('/DeleteSafariStock','CompanyController@DeleteSafariStock')->name('DeleteSafariStock');
Route::get('/createQrProduct','CompanyController@createQrProduct')->name('createQrProduct');
Route::get('/PrintQrProduct','CompanyController@PrintQrProduct')->name('PrintQrProduct');
Route::get('/SearchUser','CompanyController@SearchUser')->name('SearchUser');
Route::get('/Products','CompanyController@Products')->name('Products');
Route::get('/IsProductExist','CompanyController@IsProductExist')->name('IsProductExist');
Route::post('/CreateStockProduct','CompanyController@CreateStockProduct')->name('CreateStockProduct');
Route::get('/updateProducts','CompanyController@updateProducts')->name('updateProducts');
Route::post('/EditProducts','CompanyController@EditProducts')->name('EditProducts');
Route::post('/EditStockQty','CompanyController@EditStockQty')->name('EditStockQty');
Route::post('/deleteStockQty','CompanyController@deleteStockQty')->name('deleteStockQty');
Route::post('/EditStockFactPrice','CompanyController@EditStockFactPrice')->name('EditStockFactPrice');
Route::get('/updateDataOrder','CompanyController@updateDataOrder')->name('updateDataOrder');
Route::post('/placeOrder','CompanyController@placeOrder')->name('placeOrder');
Route::get('/EditTOrder','CompanyController@EditTOrder')->name('EditTOrder');
Route::get('/EditOrder','CompanyController@EditOrder')->name('EditOrder');//Edit Original Order
Route::get('/deleteTSingleOrder','CompanyController@deleteTSingleOrder')->name('deleteTSingleOrder');
Route::get('/deleteTOrder','CompanyController@deleteTOrder')->name('deleteTOrder');
Route::get('/ViewTempOrder','CompanyController@ViewTempOrder')->name('ViewTempOrder');
Route::get('/ViewUserTempOrder','CompanyController@ViewUserTempOrder')->name('ViewUserTempOrder');
Route::get('/displayCalculate','CompanyController@displayCalculate')->name('displayCalculate');
Route::post('/calculateAll','CompanyController@calculateAll')->name('calculateAll');
Route::get('/GetDispTempCalculator','CompanyController@GetDispTempCalculator')->name('GetDispTempCalculator');
Route::get('/ResetTempCalculator','CompanyController@ResetTempCalculator')->name('ResetTempCalculator');
Route::post('/SaveCalculateTemp','CompanyController@SaveCalculateTemp')->name('SaveCalculateTemp');
Route::post('/UpdatecalculateTemp','CompanyController@UpdatecalculateTemp')->name('UpdatecalculateTemp');
Route::post('/DeleteCalculateTemp','CompanyController@DeleteCalculateTemp')->name('DeleteCalculateTemp');
Route::get('/GetAllcalculateTemp','CompanyController@GetAllcalculateTemp')->name('GetAllcalculateTemp');
Route::get('/UseThisCalculateTemp','CompanyController@UseThisCalculateTemp')->name('UseThisCalculateTemp');
Route::post('/SubmitOrder','CompanyController@SubmitOrder')->name('SubmitOrder');

Route::get('/viewSales','CompanyController@viewSales')->name('viewSales');
Route::get('/viewSalesByUid','CompanyController@viewSalesByUid')->name('viewSalesByUid');
Route::get('/GetDebt','CompanyController@GetDebt')->name('GetDebt');
Route::post('/PaidDept','CompanyController@PaidDept')->name('PaidDept');
Route::post('/EditPaidDept','CompanyController@EditPaidDept')->name('EditPaidDept');
Route::get('/viewDept','CompanyController@viewDept')->name('viewDept');
Route::get('/viewPaidDept','CompanyController@viewPaidDept')->name('viewPaidDept');
Route::get('/viewSafeBalance','CompanyController@viewSafeBalance')->name('viewSafeBalance');
Route::get('/viewBorrowBalance','CompanyController@viewBorrowBalance')->name('viewBorrowBalance');
Route::get('/viewSafeBorrow','CompanyController@viewSafeBorrow')->name('viewSafeBorrow');
Route::post('/repaidBack','CompanyController@repaidBack')->name('repaidBack');
Route::get('/confirmRepaidBack','CompanyController@confirmRepaidBack')->name('confirmRepaidBack');
Route::get('/viewRepay','CompanyController@viewRepay')->name('viewRepay');
Route::get('/OrderViewCount','CompanyController@OrderViewCount')->name('OrderViewCount');
Route::get('/OrderViewByUid','CompanyController@OrderViewByUid')->name('OrderViewByUid');
Route::get('/StockViewDeliver','CompanyController@StockViewDeliver')->name('StockViewDeliver');
Route::get('/StockCountEdit','CompanyController@StockCountEdit')->name('StockCountEdit');
Route::post('/StockCount','CompanyController@StockCount')->name('StockCount');
Route::post('/addSpending','CompanyController@addSpending')->name('addSpending');
Route::get('/updateSpending','CompanyController@updateSpending')->name('updateSpending');
Route::get('/viewSpending','CompanyController@viewSpending')->name('viewSpending');
/*safari*/
Route::get('/SafariGetAll','CompanyController@CompanySafariGetAll')->name('CompanySafariGetAll');
Route::post('/SafariCreate','CompanyController@CompanySafariCreate')->name('CompanySafariCreate');
Route::post('/SafariEdit','CompanyController@CompanySafariEdit')->name('CompanySafariEdit');
Route::post('/SafariDelete','CompanyController@CompanySafariDelete')->name('CompanySafariDelete');

Route::get('/SafariItemSearch','CompanyController@CompanySafariItemSearch')->name('CompanySafariItemSearch');
Route::post('/SafariAddItem','CompanyController@CompanySafariAddItem')->name('CompanySafariAddItem');
Route::post('/SafariEditItem','CompanyController@CompanySafariEditItem')->name('CompanySafariEditItem');
Route::post('/SafariDeleteItem','CompanyController@CompanySafariDeleteItem')->name('CompanySafariDeleteItem');
Route::post('/SafariSpent','CompanyController@CompanySafariSpent')->name('CompanySafariSpent');
Route::get('/SafariCalculate','CompanyController@CompanySafariCalculate')->name('CompanySafariCalculate');
Route::get('/AdminViewUsers','AdminController@AdminViewUsers')->name('AdminViewUsers');
Route::get('/AdminChangePermission','AdminController@AdminChangePermission')->name('AdminChangePermission');
Route::get('/AdminChangePlatform','AdminController@AdminChangePlatform')->name('AdminChangePlatform');

/*Users */


/* Account*/

Route::get('/view','AccountController@view')->name('view');
Route::post('/update','AccountController@update')->name('update');
Route::post('/delete','AccountController@delete')->name('delete');

/*Account*/

/*-Participate */







});
