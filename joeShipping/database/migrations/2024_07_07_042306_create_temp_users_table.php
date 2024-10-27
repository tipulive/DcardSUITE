<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateTempUsersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('temp_users', function (Blueprint $table) {
            $table->id();
            $table->string('uid')->index('uid')->unique();
            $table->string('sessionKey')->default('0')->index('sessionKey');
            $table->string('location')->default('none')->index('location');
            $table->string('name')->default('none')->index('location');

            $table->dateTime('dateOn')->nullable()->index('dateOn');
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
        Schema::dropIfExists('temp_users');
    }
}
