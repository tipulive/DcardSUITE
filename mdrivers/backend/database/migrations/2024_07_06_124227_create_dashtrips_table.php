<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateDashtripsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('dashtrips', function (Blueprint $table) {
            $table->id();
            $table->string('uid')->index('uid');//Uid
            //$table->string('timeOn')->default('none')->index('timeOn');//
            $table->dateTime('dateOn')->nullable()->index('dateOn');// itariki izahagurukiraho
            $table->string('location')->default('none')->index('location');//
            $table->string('origin')->default('none')->index('origin');//
            $table->string('destination')->default('none')->index('destination');
            $table->string('tag')->default('none')->index('tag');
            $table->string('seatAv')->default('none')->index('seatAv');//
            $table->string('seatCount')->default('none')->index('seatCount');//
            $table->string('sessionKey')->default('none')->index('sessionKey');//
            $table->string('visibleStatus')->default('none')->index('visibleStatus');//
            $table->string('status')->default('none')->index('status');//
//
            $table->string('client')->default('none')->index('client');//
            $table->string('numberPlate')->default('none')->index('numberPlate');//
            $table->string('CompanyName')->default('none')->index('CompanyName');//
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
        Schema::dropIfExists('dashtrips');
    }
}
