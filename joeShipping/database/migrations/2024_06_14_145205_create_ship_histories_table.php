<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateShipHistoriesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('ship_histories', function (Blueprint $table) {
            $table->id();
            $table->string('uid')->index('uid');//Uid
            $table->string('uidUser')->default('none')->index('uidUser');//
            $table->string('name')->default('none');//
            $table->string('PhoneNumber')->default('none')->index('PhoneNumber');
            $table->string('uidCreator')->default('none')->index('uidCreator');//uyakiriye
            $table->string('subscriber')->default('none')->index('subscriber');
            $table->string('marks')->default('none');
            $table->string('driverName')->default('none');
            $table->string('driverTel')->default('none');
            $table->string('numberPlate')->default('none');
            $table->string('origin')->default('none');
            $table->string('liveLocation')->default('none');
            $table->string('destination')->default('none');
            $table->string('status')->default('none');
            $table->string('eta')->default('none');
            $table->string('actionStatus')->default('actionStatus');
            $table->longtext('commentData')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('ship_histories');
    }
}
