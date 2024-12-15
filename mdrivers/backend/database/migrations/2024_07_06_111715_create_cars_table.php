<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCarsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('cars', function (Blueprint $table) {
            $table->id();
            $table->string('uid')->index('uid');//Uid
            $table->string('numberPlate')->default('none')->index('numberPlate');//
            $table->string('carsName')->default('none')->index('carsName');//
            $table->string('numberSeat')->default('none')->index('numberSeat');//
            $table->string('status')->default('none')->index('status');//
            $table->string('uidCreator')->default('none')->index('uidCreator');//uyakiriye
            $table->string('subscriber')->default('none')->index('subscriber');
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
        Schema::dropIfExists('cars');
    }
}
