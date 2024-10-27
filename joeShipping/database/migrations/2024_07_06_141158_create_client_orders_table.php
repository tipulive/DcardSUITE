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
            $table->dateTime('dateOn')->nullable()->index('dateOn');
            //$table->string('timeOn')->default('none')->index('timeOn');//
            $table->string('location')->default('none')->index('location');//
            $table->string('status')->default('none')->index('status');//
            $table->string('paidStatus')->default('none')->index('paidStatus');//
            $table->string('ref')->default('none')->index('ref');//
            $table->string('client')->default('none')->index('client');//clientNumber
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
        Schema::dropIfExists('client_orders');
    }
}
