<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateClientOrdersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('client_orders', function (Blueprint $table) {
            $table->id();
            $table->string('uid')->index('uid');//Uid
            $table->string('uidSeat')->index('uidSeat')->unique;//Uid
            $table->string('seat')->index('seat')->default('none');//Uid
            $table->dateTime('dateOn')->nullable()->index('dateOn');
            //$table->string('timeOn')->default('none')->index('timeOn');//
            $table->string('uidUser')->default('none')->index('uidUser');//
            $table->string('name')->default('none')->index('name');//
            $table->string('phone')->default('none')->index('phone');//
            $table->string('status')->default('none')->index('status');//
            $table->string('paidStatus')->default('none')->index('paidStatus');//
            $table->string('paidType')->default('none')->index('paidType');//
            $table->string('ref')->default('none')->index('ref');//

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
        Schema::dropIfExists('client_orders');
    }
}
