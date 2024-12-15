<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateAppointmentsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('appointments', function (Blueprint $table) {
            $table->id();
            $table->String('uid')->index('uid');
            $table->String('codeb')->default('none')->index('codeb');
            $table->String('limitb')->default('none')->index('limitb');
            $table->integer('limitCounter')->default(0);
            $table->json('limitJson')->nullable();
            $table->String('status')->default('none')->index('status');
            $table->dateTime('startDate')->nullable()->index('startDate');
            $table->dateTime('endDate')->nullable()->index('endDate');
            $table->String('optionKey')->default('none')->index('optionKey');
            $table->string('uidCreator')->index('uidCreator');
            $table->longtext('commentData')->nullable();
             $table->string('subscriber')->default('none')->index("subscriber");//company Name

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
        Schema::dropIfExists('appointments');
    }
}
