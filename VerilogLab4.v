



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

wire[9:0] led_temp;
wire midi_z;



assign led_out[7:0] = led_temp[8:1];
assign midi_z = midi;


led z(midi_z,frame,led_temp);

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

module led(midi_z,frame,led_temp);


input midi_z;
input frame;
output[9:0] led_temp;

reg[9:0] sendLed;
reg[4:0] x;
assign led_temp = sendLed;
always @(*) begin
	case(frame)  
		

		3'b001:begin 
			for(x=0; x<10 ; x=x+1) begin
				sendLed[x] = midi_z;
			end
			end
		
	endcase
end
endmodule


