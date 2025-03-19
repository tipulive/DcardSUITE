<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateClientApplicationsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('client_applications', function (Blueprint $table) {
            $table->id();
            $table->String('uid')->default('none')->index('uid');
            $table->String('codeb')->default('none')->index('codeb');
            $table->String('uidCode')->default('none')->index('uidCode');

            $table->String('limitUid')->default('none')->index('limitUid')->unique();

            $table->String('status')->default('none')->index('status');
            $table->dateTime('startDate')->nullable()->index('startDate');
            $table->dateTime('endDate')->nullable()->index('endDate');
            $table->String('optionKey')->default('none')->index('optionKey');
            $table->string('uidCreator')->index('uidCreator');
            $table->string('subscriber')->index('subscriber');
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
        Schema::dropIfExists('client_applications');
    }
}
