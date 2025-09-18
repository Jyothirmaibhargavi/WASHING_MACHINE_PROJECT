`timescale 1ns/1ps

module WM_tb;

    reg clk;
    reg res;
    reg start;
    reg pause;
    wire done;

    // Instantiate the washing machine FSM
    washing_machine dut (
        .clk(clk),
        .res(res),
        .start(start),
        .pause(pause),
        .done(done)
    );

    // Clock generation: 10ns period
    initial clk = 0;
    always #5 clk = ~clk;

    // Test sequence
    initial begin
        // Initialize inputs
        res = 1; start = 0; pause = 0;
        #12 res = 0;   // Release reset

        // Start the washing machine
        #10 start = 1;
        #10 start = 0;

        // Let it run for a few cycles
        #30;

        // Pause simulation
        pause = 1;
        $display("Paused at time=%0t", $time);
        #20;
        pause = 0;
        $display("Resumed at time=%0t", $time);

        // Wait until done
        wait(done == 1);
        $display("Washing cycle DONE at time=%0t", $time);

        #20 $finish;
    end

    // Monitor state change 
    initial begin
        $monitor("Time=%0t |count=%0d | start=%0d |pause=%0d | done=%0d" , $time,dut.count,start,pause,done);
    end

endmodule

