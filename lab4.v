module lab4(midi, clk, rst_n, led );

input clk;
input rst_n;
input midi;
output [7:0] led;

reg[20:0] cnt;
wire[20:0] cnt_nxt;

reg[7:0] ledreg;
reg[9:0] note;
reg[29:0] bits;

assign led = ledreg;
assign cnt_nxt = cnt + 1'b1;


always @(posedge clk) begin
	if(!rst_n) begin
	ledreg = 8'b0;
	end
	if(!midi) begin
	//MidiNote(midi,clk);
	//cnt <= cnt_nxt;
	ledreg = 8'b00011100;
	
	end
end

endmodule
