// in this protocol:
// Write data is provided in a single clock along with the address,
// while read data is received on the next clock.
// And no transactions can be started during that time indicated by "ready" signal
module reg_ctr1
    #(
    parameter ADDR_WIDTH = 8,
    parameter DATA_WIDTH = 16,
    parameter DEPTH = 256,
    parameter RESET_VAL = 16'h1234)
    (input                           clk,
     input                           rstn,
     input  [ADDR_WIDTH-1:0]         addr,
     input                           sel,
     input                           wr,
     input [DATA_WIDTH-1:0]          wdata,

     output reg [DATA_WIDTH-1:0]     rdata,
     output reg                      ready); //signal starts transactions
    
     // memory to store data for each addr
    reg [DATA_WIDTH-1:0]    ctrl [DEPTH];

    reg ready_d1y;
    reg ready_pe;

    // If reset, clear the memory element.
    // Else,
      // store the addr for valid writes
      // or provide read data back for reads
    always@(posedge clk) begin
        if(!rstn) begin
            for(int i = 0; i < DEPTH; i += 1) begin
                ctrl[i] <= RESET_VAL;
            end
        end else begin
            if(sel & ready & wr) begin
                ctrl[addr] <= wdata;
            end

            if(sel & ready & !wr) begin
                rdata <= ctrl[addr];
            end else begin
                rdata <= 0;
            end
        end
    end

    // Ready is driven using this block
    // During reset, drive ready as 1
    // Else drive ready low for clock low
    // for a read until the data is given back
    always@(posedge clk) begin
        if(!rstn) begin
            ready <= 1;
        end else begin
            if(sel & ready_pe) begin
                ready <= 1;
            end

            if(sel&ready&!wr) begin
                ready<=0;
            end
        end
    end

    // Drive internal signal accordingly
    always@(posedge clk)
    begin
        if(!rstn) ready_d1y <= 1;
        else        ready_d1y <= ready;
    end

    assign ready_pe = ~ready & ready_d1y;
endmodule
