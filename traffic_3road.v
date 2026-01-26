DESIGN FILE,,,,


module traffic_3road (
    input clk,
    input reset,
    input emergency,
    input ped_req,                // pedestrian request
    output reg [2:0] lightA,
    output reg [2:0] lightB,
    output reg [2:0] lightC,
    output reg ped_signal          // pedestrian WALK signal
);

    // State declaration
    parameter S0 = 3'b000, // A Green
              S1 = 3'b001, // A Yellow
              S2 = 3'b010, // B Green
              S3 = 3'b011, // B Yellow
              S4 = 3'b100, // C Green
              S5 = 3'b101, // C Yellow
              S6 = 3'b110; // Pedestrian Crossing

    parameter PED_TIME = 5; // pedestrian crossing time

    reg [2:0] state, next_state;
    reg [3:0] counter;

    // State & counter register
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state   <= S0;
            counter <= 0;
        end else begin
            state <= next_state;

            if (state != next_state)
                counter <= 0;
            else
                counter <= counter + 1;
        end
    end

    // Next state logic
    always @(*) begin
        next_state = state;

        if (emergency)
            next_state = S0; // Road A priority
        else begin
            case (state)
                S0: if (counter == 10) next_state = S1;

                S1: if (counter == 3)
                        next_state = ped_req ? S6 : S2;

                S2: if (counter == 10) next_state = S3;

                S3: if (counter == 3)
                        next_state = ped_req ? S6 : S4;

                S4: if (counter == 10) next_state = S5;

                S5: if (counter == 3)
                        next_state = ped_req ? S6 : S0;

                S6: if (counter == PED_TIME)
                        next_state = S2; // resume traffic

                default: next_state = S0;
            endcase
        end
    end

    // Output logic (Moore FSM)
    always @(*) begin
        // default outputs
        lightA = 3'b100;
        lightB = 3'b100;
        lightC = 3'b100;
        ped_signal = 1'b0;

        case (state)
            S0: lightA = 3'b001; // A Green
            S1: lightA = 3'b010; // A Yellow
            S2: lightB = 3'b001; // B Green
            S3: lightB = 3'b010; // B Yellow
            S4: lightC = 3'b001; // C Green
            S5: lightC = 3'b010; // C Yellow
            S6: ped_signal = 1'b1; // Pedestrian WALK
        endcase
    end

endmodule
