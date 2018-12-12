



module Lab4Verilog1(clk, rst_n, midi,led_out);

input clk;
input rst_n;
input midi;

output[7:0] led_out;

wire clock_c;
wire lessThan;
wire reset;
wire midi_in;

assign clock_c = clk;
assign reset = rst_n;
assign midi_in = midi; 

counter y(clock_c,reset,midi_in,lessThan);

wire clock_f;
wire frame;
wire lessThanIn;

assign clock_f = clk;

assign lessThanIn = lessThan;
frameSelect x(frame, clock_f, lessThanIn);

wire[9:0] sendLed;
wire midi_z;
wire clock_l;

assign sendLed[8:1] = led_out[7:0];
assign midi_z = midi;
assign clock_l = clk;

led z(clock_l,midi_z,frame,sendLed);


wire clock_r;
wire midi_r;
wire frame_r;
wire[9:0] led_r;

assign clock_r = clk;
assign midi_r = midi;
assign frame_r = frame;
assign led_r[9:0] = sendLed[9:0];

record r(clock_r,midi_r,frame_r,led_r);

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

module counter(clk, rst_n, midi,lessThan);

input clk;
input rst_n;
input midi;
output lessThan;

reg a;
reg b;
reg[10:0] c ;
wire numTime;

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

reg[9:0] x;
assign sendLed[9:0] = x[9:0];

always @(*) begin
	case(frame)  
		
		3'b001:begin
		      r;
					end
	    
	    3'b010:begin
			 
			   end
	    
		3'b101:begin
			  x = 9'b0;
			   end
		
	endcase
end
endmodule

module record(clk,midi,frame,led);

input wire frame;
input wire clk;
input wire midi;
output led[9:0];

reg[3:0] cnt;
wire[3:0] cnt_nxt;
assign cnt_nxt = cnt + 1'b1;

always @(posedge clk) begin
if (cnt != 4'b1010) begin
	led[cnt] = midi;
	cnt <= cnt_nxt;
end 
else begin
cnt <= 4'b0;
end
end
endmodule


