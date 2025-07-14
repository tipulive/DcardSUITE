<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreatePlaquesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('plaques', function (Blueprint $table) {
            $table->id();

            $table->string('userId')->index(); // foreign key to users table
            $table->string('plaque')->index(); // plaque ID, must be unique
            $table->string('tel')->nullable(); // phone number

            $table->string('vin')->nullable()->index(); // 17-character Vehicle Identification Number
            $table->string('vMake')->nullable(); // Manufacturer
            $table->string('vModel')->nullable(); // Model
            $table->string('vYear')->nullable(); // Production year as string (or use integer)
            $table->string('vEngNumber')->nullable(); // Engine Number
            $table->string('vFuelType')->nullable(); // Fuel type
            $table->string('vBodyType')->nullable(); // Body type
            $table->string('vColor')->nullable(); // Color
            $table->string('vClass')->nullable(); // Vehicle class
            $table->string('vEngSize')->nullable(); // Engine size

            $table->string('uidPrice')->index()->nullable(); // Assuming string, or change to float if numeric
            $table->string('price')->nullable(); // Assuming string, or change to float if numeric
            $table->string('status')->default('none'); // Current status
            $table->string('statusLive')->default("none"); // Is the status live?
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
        Schema::dropIfExists('plaques');
    }
}
