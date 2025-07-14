<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateDrivingsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('drivings', function (Blueprint $table) {
            $table->id();
            $table->string('userId')->index(); // assuming indangamuntu is a string (like national ID)
            $table->string('category');
            $table->string('DNO')->index()->nullable();//driving number

            $table->string('status')->index();
            $table->string('statusLive')->index();

            $table->string('uidCreator')->index('uidCreator');
            $table->string('subscriber')->default('none')->index("subscriber");
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
        Schema::dropIfExists('drivings');
    }
}
