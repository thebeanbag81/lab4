



module Lab4Verilog1(clk, rst_n, midi,led_out);

input clk;
input rst_n;
input midi;

output[7:0] led_out;

wire clock_c;
wire lessThan;
wire reset;
wire midi_in;
wire counterVal;

assign clock_c = clk;
assign reset = rst_n;
assign midi_in = midi; 


counter y(clock_c,reset,midi_in,lessThan, counterVal);

//wire clock_f;
wire frame;
wire lessThanIn;

assign clock_f = clk;
assign lessThanIn = lessThan;

frameSelect x(frame, clk, lessThanIn);

wire[9:0] sendLed;
wire midi_z;


assign led_out[7:0] = sendLed[8:1];
assign midi_z = midi;


led z(clk,midi_z,frame,sendLed);

wire[6:0] bitNum;


bitCount bC(lessThanIn, counterVal, clk, rst_n, bitNum);

endmodule

module frameSelect( frame, clk, lessThanIn);
	input clk;
	input lessThanIn;
	output[2:0] frame; 

	reg d;
	reg e;
	reg[2:0] f;
	
assign frame = f;

always @ (posedge clk) begin

	d<=lessThanIn;
	e<=d;

	if(f >= 3'b110) begin 
		f<= f + 2'b10;
	end
	
	else begin
		f<= (d^e)+f;
	end
		
end

endmodule

module counter(clk, rst_n, midi,lessThan,counterVal);

input clk;
input rst_n;
input midi;
output lessThan;
output[10:0] counterVal;

reg a;
reg b;
reg[10:0] c ;
wire numTime;

assign counterVal = c;
assign numTime = c>=1216;
assign lessThan = numTime;

always @ (posedge clk) begin

	if(!rst_n) begin
		a<=11'h000;
		b<=1'b0;
		c<=1'b0;
	end	

	if(!midi) begin
		a<=numTime+1'b1;
	end

	else begin
		a<=a+1'b1;
	end

	if((a+b)^(b+numTime)) begin
		c<=(1+numTime);
	end

	else begin
		c<=1'b0;
	end

	b<=midi;

	end
endmodule 

module led(clk,midi_z,frame,sendLed);

input clk;
input midi_z;
input frame;
output[9:0] sendLed;

reg[9:0] sendLed;
wire[9:0] x;
wire[9:0] led_temp;
assign x[9:0] = sendLed; 



always @(*) begin
	case(frame)  
		
		3'b001:begin
				//record
					end
	    
	    3'b010:begin
			sendLed[9:0] = led_temp[9:0];
			   end
	    
		3'b101:begin
			    sendLed[9:0] = 10'b0;
			   end
		
	endcase
end
endmodule
/*
module record(clk,midi_z,led_temp);

input clk;
input midi_z;
output[9:0] led_temp;

reg[3:0] cnt;
wire[3:0] cnt_nxt;
assign cnt_nxt = cnt + 1'b1;

always @(posedge clk) begin
if (cnt != 3'b1010) begin
	led_temp[cnt] = midi_z;
	cnt <= cnt_nxt;
end 
else begin
cnt = cnt + 3'b0101;
end
end
endmodule

*/

module bitCount(lessThanIn, counterVal, clk, rst_n, bitNum);
input lessThanIn;
input[10:0] counterVal;
input clk;
input rst_n;
output[6:0] bitNum;

reg[6:0] numBits;
wire lTI;
wire[10:0] cV;
wire andBoth;

assign cV = counterVal;
assign bitNum = numBits;

always @(*) begin

	if(!rst_n) begin
		numBits = 7'b0;
	end
	
	if((((cV%64)==0) && ((cV%128)==64))) begin
		numBits = numBits + 1;
	end
	
	else if(!(((cV%64)==0) && ((cV%128)==64))) begin
		numBits = numBits ;
	end
	
end
endmodule
	