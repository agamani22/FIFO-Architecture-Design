// DESIGNED A SYNCHRONOUS FIFO
`timescale 1ns/1ps
module fifo(clk,reset,wr_en,rd_en,din,dout,full,empty);
  input clk,reset; // as synchronous FIFO , so same clock for read & write
  input wr_en,rd_en;
  input [7:0]din;
  output [7:0]dout;
  output full,empty;
  
  reg [7:0]mem[0:15];//declaration of RAM, of width 8 bits & depth 16 bits
  wire clk,reset;
  wire wr_en,rd_en;
  wire [7:0]din;
  reg [7:0]dout;
  wire full,empty; // since we  use assign statmt for FULL & EMPTY , so we must declare them as wires
  reg [3:0]addr;
  integer i;
  assign full = (addr ==4'b1111) ? 1'b1 : 1'b0; // if address reaches the topmost location of the RAM memory, then put full flag is high
  assign empty = (addr ==4'b0000) ? 1'b1 : 1'b0;
  
  always@(posedge clk)    // creating combinational logic using always block
    begin
      if(reset)// here when reset is given, we initialize the address register (which is inside counter module) and all memory element to zero 
        begin
        	addr = 4'b0000;
      		for(i=0;i<=15;i=i+1) 
            mem[i] = 8'b0;// Since each memory element (which are inside RAM) width is 8bits
        end
      else if(wr_en | rd_en)//read or write
        begin
          if(wr_en && (!full))// checking that its write operation and the FIFO  is not FULL
            begin
              mem[addr]=din;// here we initiaized the address, and from next step onwards w'll just increment the address
            	addr = addr + 1;
            end
          else
            if(rd_en && (!empty)) // read means to take the data out from the bottom most memory element in FIFO , here addr 0 , is bottom most element address
              begin
                dout =mem[0];
                mem[0] = mem[1];
                mem[1] = mem[2];
                mem[2] = mem[3];
                mem[3] = mem[4];
                mem[4] = mem[5];
                mem[5] = mem[6];
                mem[6] = mem[7];
                mem[7] = mem[8];
                mem[8] = mem[9];
                mem[9] = mem[10];
                mem[10] = mem[11];
                mem[11] = mem[12];
                mem[12] = mem[13];
                mem[13] = mem[14];
                mem[14] = mem[15];
                mem[15] = 8'b0;
                   addr = addr - 1;         
                
              end
              
        end
      
    end
endmodule
