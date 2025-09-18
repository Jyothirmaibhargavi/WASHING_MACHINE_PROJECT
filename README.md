# WASHING_MACHINE_PROJECT

🧺 Washing Machine FSM (Verilog)
📌 Project Overview

This project implements a Washing Machine Controller as a Finite State Machine (FSM) in Verilog.
It models the typical washing process stages — Fill, Wash, Rinse, Spin, Done — with configurable cycle durations, and includes a pause feature to freeze the process mid-cycle.

The project also includes a self-checking testbench that simulates the washing machine’s behavior with start, pause, and resume signals, printing the FSM state, counter, and done status for verification.

⚙️ Design (DUT: washing_machine.v)
🔑 Features

FSM States:

IDLE → Waiting for start

FILL → Filling water

WASH → Washing clothes

RINSE → Rinsing

SPIN → Spinning to remove water

DONE → Cycle complete

Pause Support: The FSM can pause in any state, freezing the counter until resumed.

Configurable Stage Durations using parameters:

parameter FILL_CYCLES  = 5;
parameter WASH_CYCLES  = 10;
parameter RINSE_CYCLES = 7;
parameter SPIN_CYCLES  = 4;


Done Signal: Asserted when the washing cycle is finished.

🔧 Inputs & Outputs
Signal	Direction	Description
clk	Input	Clock signal
res	Input	Active-high reset
start	Input	Start pulse to begin washing cycle
pause	Input	Pause signal (1 = hold state, 0 = run)
done	Output	High when washing cycle is complete
🎨 FSM State Diagram
stateDiagram-v2
    [*] --> IDLE
    IDLE --> FILL : start
    FILL --> WASH : after FILL_CYCLES
    WASH --> RINSE : after WASH_CYCLES
    RINSE --> SPIN : after RINSE_CYCLES
    SPIN --> DONE : after SPIN_CYCLES
    DONE --> IDLE

🧪 Testbench (TB: WM_tb.v)
🛠️ Features

Clock Generator (10 ns period).

Stimulus:

Resets the FSM.

Sends a start pulse to begin washing.

Pauses the FSM mid-cycle and resumes it later.

Waits until the cycle completes (done=1).

Monitors internal signals:

Current state (IDLE/FILL/WASH/RINSE/SPIN/DONE).

🎯 Learning Outcomes

Designing FSM-based controllers in Verilog.

Using counters for stage timing.

Handling pause/resume functionality in FSMs.

Writing testbenches with stimulus & monitoring.

count value for each stage.

pause and done signals.
