module washing_machine (clk,res,start,pause,done);

parameter IDLE = 6'b000001; 
parameter FILL = 6'b000010;
parameter WASH = 6'b000100;
parameter RINSE= 6'b001000;
parameter SPIN = 6'b010000;
parameter DONE = 6'b100000;

input clk,res,start,pause;
output reg done;

reg [5:0]state,next_state;
reg[7:0] count;                 // counter to track duration of each state

 // Duration for each stage
  parameter FILL_CYCLES  = 5;
  parameter WASH_CYCLES  = 10;
  parameter RINSE_CYCLES = 7;
  parameter SPIN_CYCLES  = 4;

//sequential logic : satate transitions and count
always @(posedge clk or posedge res) begin
  if (res) begin
  state<=IDLE;
  count<=0;
  done<=0;
  end
  else if (!pause) begin  // only update if not paused 
  state<=next_state;
  if (state!=next_state)
   count<=0;
  else 
   count<=count+1;
   done<=(next_state==DONE);
  end 
 end

//combinational logic
always @(*) begin
    next_state=state;           //remain in current satate
case(state)
    IDLE: begin
	 if(start) next_state=FILL;  // start washinhg
	end 

	FILL: begin
	 if(count>=FILL_CYCLES-1) next_state=WASH;   //Move to WASH after FILL_CYCLES
	end 

    WASH: begin
	 if(count>=WASH_CYCLES-1) next_state=RINSE;  // Move to RINSE after WASH_CYCLES
	end 

    RINSE: begin
	 if(count>=RINSE_CYCLES-1) next_state=SPIN; //move to SPIN after RINSE_CYCLES
	end 

    SPIN: begin
	 if(count>=SPIN_CYCLES-1) next_state=DONE; //Move to DONE after SPIN_CYCLES
	end 

   DONE: begin
	 next_state=IDLE;                           // After DONE, go back to IDLE
	end 

	default : next_state=IDLE;
	endcase
   end	
endmodule
 

//# Time=0 |count=0 | start=0 |pause=0 | done=0
//# Time=15000 |count=1 | start=0 |pause=0 | done=0
//# Time=22000 |count=1 | start=1 |pause=0 | done=0
//# Time=25000 |count=0 | start=1 |pause=0 | done=0
//# Time=32000 |count=0 | start=0 |pause=0 | done=0
//# Time=35000 |count=1 | start=0 |pause=0 | done=0
//# Time=45000 |count=2 | start=0 |pause=0 | done=0
//# Time=55000 |count=3 | start=0 |pause=0 | done=0
//# Paused at time=62000
//# Time=62000 |count=3 | start=0 |pause=1 | done=0
//# Resumed at time=82000
//# Time=82000 |count=3 | start=0 |pause=0 | done=0
//# Time=85000 |count=4 | start=0 |pause=0 | done=0
//# Time=95000 |count=0 | start=0 |pause=0 | done=0
//# Time=105000 |count=1 | start=0 |pause=0 | done=0
//# Time=115000 |count=2 | start=0 |pause=0 | done=0
//# Time=125000 |count=3 | start=0 |pause=0 | done=0
//# Time=135000 |count=4 | start=0 |pause=0 | done=0
//# Time=145000 |count=5 | start=0 |pause=0 | done=0
//# Time=155000 |count=6 | start=0 |pause=0 | done=0
//# Time=165000 |count=7 | start=0 |pause=0 | done=0
//# Time=175000 |count=8 | start=0 |pause=0 | done=0
//# Time=185000 |count=9 | start=0 |pause=0 | done=0
//# Time=195000 |count=0 | start=0 |pause=0 | done=0
//# Time=205000 |count=1 | start=0 |pause=0 | done=0
//# Time=215000 |count=2 | start=0 |pause=0 | done=0
//# Time=225000 |count=3 | start=0 |pause=0 | done=0
//# Time=235000 |count=4 | start=0 |pause=0 | done=0
//# Time=245000 |count=5 | start=0 |pause=0 | done=0
//# Time=255000 |count=6 | start=0 |pause=0 | done=0
//# Time=265000 |count=0 | start=0 |pause=0 | done=0
//# Time=275000 |count=1 | start=0 |pause=0 | done=0
//# Time=285000 |count=2 | start=0 |pause=0 | done=0
//# Time=295000 |count=3 | start=0 |pause=0 | done=0
//# Washing cycle DONE at time=305000
//# Time=305000 |count=0 | start=0 |pause=0 | done=1
//# Time=315000 |count=0 | start=0 |pause=0 | done=0
//# ** Note: $finish    : WM_tb.v(48)
//
