<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateMeasurementsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('measurements', function (Blueprint $table) {
            $table->id();
            $table->string('uid')->default('none')->index('uid');

            $table->string('name')->default('none')->index('name');

            $table->longtext('commentData')->nullable();
            $table->string('uidCreator')->default('none')->index('uidCreator');
            $table->string('subscriber')->default('none')->index("subscriber");
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
        Schema::dropIfExists('measurements');
    }
}
