module bcd (
    start_value,
    reset,
    clock,
    increment,
    convert,
    ready,
    bcd_value,
    int_value,
    num_digits,
    is_invalid
);

    input [32:0] start_value;
    input reset;
    input clock;
    input increment;
    input convert;
    output ready;
    output [39:0] bcd_value;
    output [32:0] int_value;
    output [4:0] num_digits;
    output is_invalid;

    wire _56;
    wire [19:0] _52;
    wire [19:0] _51;
    wire _53;
    wire [15:0] _49;
    wire [15:0] _48;
    wire _50;
    wire [11:0] _46;
    wire [11:0] _45;
    wire _47;
    wire [7:0] _43;
    wire [7:0] _42;
    wire _44;
    wire [3:0] _40;
    wire [3:0] _39;
    wire _41;
    wire [3:0] _34;
    wire [4:0] _35;
    reg _54;
    wire _32;
    wire _55;
    wire _58;
    reg _60;
    wire _1;
    reg _57;
    wire [4:0] _30;
    wire [4:0] _100;
    wire [3:0] _98;
    wire [3:0] _97;
    wire _99;
    wire [4:0] _102;
    wire [4:0] _96;
    wire [3:0] _93;
    wire _95;
    wire [4:0] _103;
    wire [4:0] _92;
    wire [3:0] _89;
    wire _91;
    wire [4:0] _104;
    wire [4:0] _88;
    wire [3:0] _85;
    wire _87;
    wire [4:0] _105;
    wire [4:0] _84;
    wire [3:0] _81;
    wire _83;
    wire [4:0] _106;
    wire [4:0] _80;
    wire [3:0] _77;
    wire _79;
    wire [4:0] _107;
    wire [4:0] _76;
    wire [3:0] _73;
    wire _75;
    wire [4:0] _108;
    wire [4:0] _72;
    wire [3:0] _69;
    wire _71;
    wire [4:0] _109;
    wire [4:0] _68;
    wire [3:0] _65;
    wire _67;
    wire [4:0] _110;
    wire [4:0] _64;
    wire [3:0] _61;
    wire _63;
    wire [4:0] _111;
    wire [4:0] _112;
    reg [4:0] _113;
    wire [4:0] _3;
    reg [4:0] _31;
    wire [32:0] _114;
    wire [32:0] _118;
    wire [32:0] _119;
    wire [32:0] _116;
    reg [32:0] _121;
    wire [32:0] _5;
    reg [32:0] _115;
    wire [39:0] _37;
    wire [3:0] _317;
    wire [3:0] _318;
    wire [3:0] _314;
    wire _315;
    wire _316;
    wire [3:0] _320;
    wire [3:0] _310;
    wire _307;
    wire _308;
    wire [3:0] _312;
    wire [3:0] _313;
    wire [3:0] _302;
    wire _299;
    wire _300;
    wire [3:0] _304;
    wire [3:0] _305;
    wire [3:0] _294;
    wire _291;
    wire _292;
    wire [3:0] _296;
    wire [3:0] _297;
    wire [3:0] _286;
    wire _283;
    wire _284;
    wire [3:0] _288;
    wire [3:0] _289;
    wire [3:0] _278;
    wire _275;
    wire _276;
    wire [3:0] _280;
    wire [3:0] _281;
    wire [3:0] _270;
    wire _267;
    wire _268;
    wire [3:0] _272;
    wire [3:0] _273;
    wire [3:0] _262;
    wire _259;
    wire _260;
    wire [3:0] _264;
    wire [3:0] _265;
    wire [3:0] _254;
    wire _251;
    wire _252;
    wire [3:0] _256;
    wire [3:0] _257;
    wire [3:0] _246;
    wire _243;
    wire _244;
    wire [3:0] _248;
    wire [3:0] _241;
    wire [3:0] _237;
    wire _239;
    wire [3:0] _233;
    wire _235;
    wire [3:0] _229;
    wire _231;
    wire [3:0] _225;
    wire _227;
    wire [3:0] _221;
    wire _223;
    wire [3:0] _217;
    wire _219;
    wire [3:0] _213;
    wire _215;
    wire [3:0] _209;
    wire _211;
    wire [3:0] _206;
    wire _208;
    wire _212;
    wire _216;
    wire _220;
    wire _224;
    wire _228;
    wire _232;
    wire _236;
    wire _240;
    wire [3:0] _249;
    wire [39:0] _321;
    wire [31:0] _125;
    wire [32:0] _127;
    wire [32:0] _8;
    wire [32:0] _124;
    reg [32:0] _129;
    wire [32:0] _9;
    reg [32:0] convert_buffer;
    wire _204;
    wire [3:0] _199;
    wire [3:0] _200;
    wire [3:0] _196;
    wire [3:0] _195;
    wire _197;
    wire _198;
    wire [3:0] _201;
    wire [3:0] _193;
    wire [3:0] _188;
    wire _190;
    wire _191;
    wire [3:0] _194;
    wire [3:0] _186;
    wire [3:0] _181;
    wire _183;
    wire _184;
    wire [3:0] _187;
    wire [3:0] _179;
    wire [3:0] _174;
    wire _176;
    wire _177;
    wire [3:0] _180;
    wire [3:0] _172;
    wire [3:0] _167;
    wire _169;
    wire _170;
    wire [3:0] _173;
    wire [3:0] _165;
    wire [3:0] _160;
    wire _162;
    wire _163;
    wire [3:0] _166;
    wire [3:0] _158;
    wire [3:0] _153;
    wire _155;
    wire _156;
    wire [3:0] _159;
    wire [3:0] _151;
    wire [3:0] _146;
    wire _148;
    wire _149;
    wire [3:0] _152;
    wire [3:0] _144;
    wire [3:0] _139;
    wire _141;
    wire _142;
    wire [3:0] _145;
    wire [3:0] _137;
    wire [3:0] _132;
    wire _134;
    wire _135;
    wire [3:0] _138;
    wire [39:0] _202;
    wire [38:0] _203;
    wire [39:0] _205;
    wire [39:0] _131;
    reg [39:0] _322;
    wire [39:0] _10;
    reg [39:0] _38;
    wire _340;
    wire [1:0] _25;
    wire vdd;
    wire gnd;
    wire _324;
    reg _325;
    wire _12;
    reg _28;
    wire _29;
    wire [1:0] _338;
    wire [1:0] _59;
    wire [5:0] _335;
    wire [5:0] _326;
    wire _14;
    wire _16;
    wire [5:0] _330;
    wire [5:0] _331;
    wire [5:0] _329;
    reg [5:0] _332;
    wire [5:0] _17;
    reg [5:0] bits_processed;
    wire _336;
    wire [1:0] _337;
    wire [1:0] _128;
    wire [1:0] _120;
    wire _19;
    wire [1:0] _333;
    wire _21;
    wire [1:0] _334;
    reg [1:0] _339;
    wire [1:0] _22;
    (* fsm_encoding="one_hot" *)
    reg [1:0] _26;
    reg _341;
    wire _23;
    assign _56 = 1'b0;
    assign _52 = _38[39:20];
    assign _51 = _38[19:0];
    assign _53 = _51 == _52;
    assign _49 = _38[31:16];
    assign _48 = _38[15:0];
    assign _50 = _48 == _49;
    assign _46 = _38[23:12];
    assign _45 = _38[11:0];
    assign _47 = _45 == _46;
    assign _43 = _38[15:8];
    assign _42 = _38[7:0];
    assign _44 = _42 == _43;
    assign _40 = _38[7:4];
    assign _39 = _38[3:0];
    assign _41 = _39 == _40;
    assign _34 = _31[4:1];
    assign _35 = { _56,
                   _34 };
    always @* begin
        case (_35)
        0:
            _54 <= gnd;
        1:
            _54 <= _41;
        2:
            _54 <= _44;
        3:
            _54 <= _47;
        4:
            _54 <= _50;
        default:
            _54 <= _53;
        endcase
    end
    assign _32 = _31[0:0];
    assign _55 = _32 ? gnd : _54;
    assign _58 = _29 ? _57 : _55;
    always @* begin
        case (_26)
        2'b11:
            _60 <= _58;
        default:
            _60 <= _57;
        endcase
    end
    assign _1 = _60;
    always @(posedge _16) begin
        if (_14)
            _57 <= _56;
        else
            _57 <= _1;
    end
    assign _30 = 5'b00000;
    assign _100 = 5'b00001;
    assign _98 = 4'b0000;
    assign _97 = _38[3:0];
    assign _99 = _97 == _98;
    assign _102 = _99 ? _30 : _100;
    assign _96 = 5'b00010;
    assign _93 = _38[7:4];
    assign _95 = _93 == _98;
    assign _103 = _95 ? _102 : _96;
    assign _92 = 5'b00011;
    assign _89 = _38[11:8];
    assign _91 = _89 == _98;
    assign _104 = _91 ? _103 : _92;
    assign _88 = 5'b00100;
    assign _85 = _38[15:12];
    assign _87 = _85 == _98;
    assign _105 = _87 ? _104 : _88;
    assign _84 = 5'b00101;
    assign _81 = _38[19:16];
    assign _83 = _81 == _98;
    assign _106 = _83 ? _105 : _84;
    assign _80 = 5'b00110;
    assign _77 = _38[23:20];
    assign _79 = _77 == _98;
    assign _107 = _79 ? _106 : _80;
    assign _76 = 5'b00111;
    assign _73 = _38[27:24];
    assign _75 = _73 == _98;
    assign _108 = _75 ? _107 : _76;
    assign _72 = 5'b01000;
    assign _69 = _38[31:28];
    assign _71 = _69 == _98;
    assign _109 = _71 ? _108 : _72;
    assign _68 = 5'b01001;
    assign _65 = _38[35:32];
    assign _67 = _65 == _98;
    assign _110 = _67 ? _109 : _68;
    assign _64 = 5'b01010;
    assign _61 = _38[39:36];
    assign _63 = _61 == _98;
    assign _111 = _63 ? _110 : _64;
    assign _112 = _29 ? _111 : _31;
    always @* begin
        case (_26)
        2'b11:
            _113 <= _112;
        default:
            _113 <= _31;
        endcase
    end
    assign _3 = _113;
    always @(posedge _16) begin
        if (_14)
            _31 <= _30;
        else
            _31 <= _3;
    end
    assign _114 = 33'b000000000000000000000000000000000;
    assign _118 = 33'b000000000000000000000000000000001;
    assign _119 = _115 + _118;
    assign _116 = _21 ? _8 : _115;
    always @* begin
        case (_26)
        2'b00:
            _121 <= _116;
        2'b10:
            _121 <= _119;
        default:
            _121 <= _115;
        endcase
    end
    assign _5 = _121;
    always @(posedge _16) begin
        if (_14)
            _115 <= _114;
        else
            _115 <= _5;
    end
    assign _37 = 40'b0000000000000000000000000000000000000000;
    assign _317 = 4'b0001;
    assign _318 = _206 + _317;
    assign _314 = 4'b1001;
    assign _315 = _206 < _314;
    assign _316 = ~ _315;
    assign _320 = _316 ? _98 : _318;
    assign _310 = _209 + _317;
    assign _307 = _209 < _314;
    assign _308 = ~ _307;
    assign _312 = _308 ? _98 : _310;
    assign _313 = _208 ? _312 : _209;
    assign _302 = _213 + _317;
    assign _299 = _213 < _314;
    assign _300 = ~ _299;
    assign _304 = _300 ? _98 : _302;
    assign _305 = _212 ? _304 : _213;
    assign _294 = _217 + _317;
    assign _291 = _217 < _314;
    assign _292 = ~ _291;
    assign _296 = _292 ? _98 : _294;
    assign _297 = _216 ? _296 : _217;
    assign _286 = _221 + _317;
    assign _283 = _221 < _314;
    assign _284 = ~ _283;
    assign _288 = _284 ? _98 : _286;
    assign _289 = _220 ? _288 : _221;
    assign _278 = _225 + _317;
    assign _275 = _225 < _314;
    assign _276 = ~ _275;
    assign _280 = _276 ? _98 : _278;
    assign _281 = _224 ? _280 : _225;
    assign _270 = _229 + _317;
    assign _267 = _229 < _314;
    assign _268 = ~ _267;
    assign _272 = _268 ? _98 : _270;
    assign _273 = _228 ? _272 : _229;
    assign _262 = _233 + _317;
    assign _259 = _233 < _314;
    assign _260 = ~ _259;
    assign _264 = _260 ? _98 : _262;
    assign _265 = _232 ? _264 : _233;
    assign _254 = _237 + _317;
    assign _251 = _237 < _314;
    assign _252 = ~ _251;
    assign _256 = _252 ? _98 : _254;
    assign _257 = _236 ? _256 : _237;
    assign _246 = _241 + _317;
    assign _243 = _241 < _314;
    assign _244 = ~ _243;
    assign _248 = _244 ? _98 : _246;
    assign _241 = _38[39:36];
    assign _237 = _38[35:32];
    assign _239 = _237 == _314;
    assign _233 = _38[31:28];
    assign _235 = _233 == _314;
    assign _229 = _38[27:24];
    assign _231 = _229 == _314;
    assign _225 = _38[23:20];
    assign _227 = _225 == _314;
    assign _221 = _38[19:16];
    assign _223 = _221 == _314;
    assign _217 = _38[15:12];
    assign _219 = _217 == _314;
    assign _213 = _38[11:8];
    assign _215 = _213 == _314;
    assign _209 = _38[7:4];
    assign _211 = _209 == _314;
    assign _206 = _38[3:0];
    assign _208 = _206 == _314;
    assign _212 = _208 ? _211 : gnd;
    assign _216 = _212 ? _215 : gnd;
    assign _220 = _216 ? _219 : gnd;
    assign _224 = _220 ? _223 : gnd;
    assign _228 = _224 ? _227 : gnd;
    assign _232 = _228 ? _231 : gnd;
    assign _236 = _232 ? _235 : gnd;
    assign _240 = _236 ? _239 : gnd;
    assign _249 = _240 ? _248 : _241;
    assign _321 = { _249,
                    _257,
                    _265,
                    _273,
                    _281,
                    _289,
                    _297,
                    _305,
                    _313,
                    _320 };
    assign _125 = convert_buffer[31:0];
    assign _127 = { _125,
                    _56 };
    assign _8 = start_value;
    assign _124 = _21 ? _8 : convert_buffer;
    always @* begin
        case (_26)
        2'b00:
            _129 <= _124;
        2'b01:
            _129 <= _127;
        default:
            _129 <= convert_buffer;
        endcase
    end
    assign _9 = _129;
    always @(posedge _16) begin
        if (_14)
            convert_buffer <= _114;
        else
            convert_buffer <= _9;
    end
    assign _204 = convert_buffer[32:32];
    assign _199 = 4'b0011;
    assign _200 = _195 + _199;
    assign _196 = 4'b0101;
    assign _195 = _38[3:0];
    assign _197 = _195 < _196;
    assign _198 = ~ _197;
    assign _201 = _198 ? _200 : _195;
    assign _193 = _188 + _199;
    assign _188 = _38[7:4];
    assign _190 = _188 < _196;
    assign _191 = ~ _190;
    assign _194 = _191 ? _193 : _188;
    assign _186 = _181 + _199;
    assign _181 = _38[11:8];
    assign _183 = _181 < _196;
    assign _184 = ~ _183;
    assign _187 = _184 ? _186 : _181;
    assign _179 = _174 + _199;
    assign _174 = _38[15:12];
    assign _176 = _174 < _196;
    assign _177 = ~ _176;
    assign _180 = _177 ? _179 : _174;
    assign _172 = _167 + _199;
    assign _167 = _38[19:16];
    assign _169 = _167 < _196;
    assign _170 = ~ _169;
    assign _173 = _170 ? _172 : _167;
    assign _165 = _160 + _199;
    assign _160 = _38[23:20];
    assign _162 = _160 < _196;
    assign _163 = ~ _162;
    assign _166 = _163 ? _165 : _160;
    assign _158 = _153 + _199;
    assign _153 = _38[27:24];
    assign _155 = _153 < _196;
    assign _156 = ~ _155;
    assign _159 = _156 ? _158 : _153;
    assign _151 = _146 + _199;
    assign _146 = _38[31:28];
    assign _148 = _146 < _196;
    assign _149 = ~ _148;
    assign _152 = _149 ? _151 : _146;
    assign _144 = _139 + _199;
    assign _139 = _38[35:32];
    assign _141 = _139 < _196;
    assign _142 = ~ _141;
    assign _145 = _142 ? _144 : _139;
    assign _137 = _132 + _199;
    assign _132 = _38[39:36];
    assign _134 = _132 < _196;
    assign _135 = ~ _134;
    assign _138 = _135 ? _137 : _132;
    assign _202 = { _138,
                    _145,
                    _152,
                    _159,
                    _166,
                    _173,
                    _180,
                    _187,
                    _194,
                    _201 };
    assign _203 = _202[38:0];
    assign _205 = { _203,
                    _204 };
    assign _131 = _21 ? _37 : _38;
    always @* begin
        case (_26)
        2'b00:
            _322 <= _131;
        2'b01:
            _322 <= _205;
        2'b10:
            _322 <= _321;
        default:
            _322 <= _38;
        endcase
    end
    assign _10 = _322;
    always @(posedge _16) begin
        if (_14)
            _38 <= _37;
        else
            _38 <= _10;
    end
    assign _340 = _21 ? gnd : vdd;
    assign _25 = 2'b00;
    assign vdd = 1'b1;
    assign gnd = 1'b0;
    assign _324 = _29 ? vdd : gnd;
    always @* begin
        case (_26)
        2'b11:
            _325 <= _324;
        default:
            _325 <= _28;
        endcase
    end
    assign _12 = _325;
    always @(posedge _16) begin
        if (_14)
            _28 <= _56;
        else
            _28 <= _12;
    end
    assign _29 = ~ _28;
    assign _338 = _29 ? _26 : _25;
    assign _59 = 2'b11;
    assign _335 = 6'b100000;
    assign _326 = 6'b000000;
    assign _14 = reset;
    assign _16 = clock;
    assign _330 = 6'b000001;
    assign _331 = bits_processed + _330;
    assign _329 = _21 ? _326 : bits_processed;
    always @* begin
        case (_26)
        2'b00:
            _332 <= _329;
        2'b01:
            _332 <= _331;
        default:
            _332 <= bits_processed;
        endcase
    end
    assign _17 = _332;
    always @(posedge _16) begin
        if (_14)
            bits_processed <= _326;
        else
            bits_processed <= _17;
    end
    assign _336 = bits_processed == _335;
    assign _337 = _336 ? _59 : _26;
    assign _128 = 2'b01;
    assign _120 = 2'b10;
    assign _19 = increment;
    assign _333 = _19 ? _120 : _26;
    assign _21 = convert;
    assign _334 = _21 ? _128 : _333;
    always @* begin
        case (_26)
        2'b00:
            _339 <= _334;
        2'b01:
            _339 <= _337;
        2'b10:
            _339 <= _59;
        2'b11:
            _339 <= _338;
        default:
            _339 <= _26;
        endcase
    end
    assign _22 = _339;
    always @(posedge _16) begin
        if (_14)
            _26 <= _25;
        else
            _26 <= _22;
    end
    always @* begin
        case (_26)
        2'b00:
            _341 <= _340;
        default:
            _341 <= gnd;
        endcase
    end
    assign _23 = _341;
    assign ready = _23;
    assign bcd_value = _38;
    assign int_value = _115;
    assign num_digits = _31;
    assign is_invalid = _57;

endmodule
module aoc (
    data$value,
    data$valid,
    reset,
    clock,
    puzzle,
    result$valid,
    result$value,
    data_ready,
    debug
);

    input [63:0] data$value;
    input data$valid;
    input reset;
    input clock;
    input [4:0] puzzle;
    output result$valid;
    output [63:0] result$value;
    output data_ready;
    output [1:0] debug;

    wire [1:0] _29;
    wire [1:0] _64;
    wire [1:0] _60;
    wire [1:0] _59;
    wire [1:0] _61;
    wire [1:0] _62;
    wire [1:0] _63;
    wire [1:0] _65;
    wire [1:0] _67;
    wire [1:0] _68;
    wire [1:0] _1;
    reg [1:0] _30;
    wire _69;
    wire _73;
    wire _71;
    wire _72;
    wire _74;
    wire _75;
    wire _3;
    reg _70;
    wire [63:0] _90;
    wire [32:0] _80;
    wire [30:0] _79;
    wire [63:0] _81;
    wire [63:0] _82;
    wire _78;
    wire [63:0] _83;
    wire [63:0] _84;
    wire [63:0] _85;
    wire [63:0] _86;
    wire [63:0] _87;
    wire [63:0] _88;
    wire [63:0] _89;
    wire [63:0] _5;
    reg [63:0] invalid_sum;
    wire [63:0] _92;
    wire [63:0] _93;
    wire [63:0] _94;
    wire [63:0] _95;
    wire [63:0] _96;
    wire [63:0] _6;
    reg [63:0] _91;
    wire _151;
    wire _152;
    wire _153;
    wire [32:0] _33;
    wire [32:0] _147;
    wire [32:0] _148;
    wire [32:0] _143;
    wire [32:0] _144;
    wire [32:0] _145;
    wire [63:0] _9;
    wire [32:0] _137;
    wire _11;
    wire [32:0] _138;
    wire [32:0] _134;
    wire [32:0] _135;
    wire _127;
    wire [32:0] _112;
    wire [32:0] _113;
    wire _57;
    wire _97;
    wire _98;
    wire _99;
    wire _100;
    wire _101;
    wire _102;
    wire _12;
    reg _52;
    wire gnd;
    wire _104;
    wire _105;
    wire _106;
    wire _107;
    wire _13;
    reg _50;
    wire [79:0] _53;
    wire _54;
    wire _55;
    wire _58;
    wire [32:0] _114;
    wire [32:0] _111;
    wire [32:0] _115;
    wire [32:0] _116;
    wire [32:0] _117;
    wire [32:0] _118;
    wire [32:0] _119;
    wire [32:0] _14;
    reg [32:0] range_counter;
    wire _16;
    wire _18;
    wire [32:0] _120;
    wire [32:0] _122;
    wire [32:0] _123;
    wire [32:0] _124;
    wire [32:0] _125;
    wire [32:0] _19;
    reg [32:0] range;
    wire _47;
    wire _48;
    wire _128;
    wire vdd;
    wire _103;
    wire _126;
    wire _129;
    wire _130;
    wire _131;
    wire _132;
    wire _20;
    reg _40;
    wire _42;
    wire [32:0] _136;
    wire [32:0] _139;
    wire [32:0] _140;
    wire [32:0] _141;
    wire [32:0] _21;
    reg [32:0] _36;
    wire _38;
    wire [32:0] _146;
    wire [32:0] _149;
    wire [32:0] _150;
    wire [32:0] _22;
    reg [32:0] _32;
    wire _34;
    wire _154;
    wire [4:0] _27;
    wire [4:0] _24;
    wire _28;
    wire _155;
    wire _25;
    reg _109;
    assign _29 = 2'b00;
    assign _64 = 2'b01;
    assign _60 = 2'b11;
    assign _59 = 2'b10;
    assign _61 = _58 ? _60 : _59;
    assign _62 = _48 ? _61 : _30;
    assign _63 = _42 ? _62 : _30;
    assign _65 = _38 ? _64 : _63;
    assign _67 = _34 ? _29 : _65;
    assign _68 = _28 ? _67 : _30;
    assign _1 = _68;
    always @(posedge _18) begin
        if (_16)
            _30 <= _29;
        else
            _30 <= _1;
    end
    assign _69 = 1'b0;
    assign _73 = _11 ? gnd : vdd;
    assign _71 = _11 ? gnd : vdd;
    assign _72 = _38 ? _71 : gnd;
    assign _74 = _34 ? _73 : _72;
    assign _75 = _28 ? _74 : _70;
    assign _3 = _75;
    always @(posedge _18) begin
        if (_16)
            _70 <= _69;
        else
            _70 <= _3;
    end
    assign _90 = 64'b0000000000000000000000000000000000000000000000000000000000000000;
    assign _80 = _53[73:41];
    assign _79 = 31'b0000000000000000000000000000000;
    assign _81 = { _79,
                   _80 };
    assign _82 = invalid_sum + _81;
    assign _78 = _53[79:79];
    assign _83 = _78 ? _82 : invalid_sum;
    assign _84 = _58 ? _83 : invalid_sum;
    assign _85 = _48 ? _84 : invalid_sum;
    assign _86 = _42 ? _85 : invalid_sum;
    assign _87 = _38 ? invalid_sum : _86;
    assign _88 = _34 ? invalid_sum : _87;
    assign _89 = _28 ? _88 : invalid_sum;
    assign _5 = _89;
    always @(posedge _18) begin
        if (_16)
            invalid_sum <= _90;
        else
            invalid_sum <= _5;
    end
    assign _92 = _48 ? _91 : invalid_sum;
    assign _93 = _42 ? _92 : _91;
    assign _94 = _38 ? _91 : _93;
    assign _95 = _34 ? _91 : _94;
    assign _96 = _28 ? _95 : _91;
    assign _6 = _96;
    always @(posedge _18) begin
        if (_16)
            _91 <= _90;
        else
            _91 <= _6;
    end
    assign _151 = _48 ? gnd : vdd;
    assign _152 = _42 ? _151 : gnd;
    assign _153 = _38 ? _109 : _152;
    assign _33 = 33'b000000000000000000000000000000000;
    assign _147 = _9[32:0];
    assign _148 = _11 ? _147 : _32;
    assign _143 = _109 ? _33 : _32;
    assign _144 = _48 ? _32 : _143;
    assign _145 = _42 ? _144 : _32;
    assign _9 = data$value;
    assign _137 = _9[32:0];
    assign _11 = data$valid;
    assign _138 = _11 ? _137 : _36;
    assign _134 = _109 ? _33 : _36;
    assign _135 = _48 ? _36 : _134;
    assign _127 = _109 ? gnd : _126;
    assign _112 = 33'b000000000000000000000000000000001;
    assign _113 = range_counter + _112;
    assign _57 = _52 == gnd;
    assign _97 = _58 ? vdd : gnd;
    assign _98 = _48 ? _97 : gnd;
    assign _99 = _42 ? _98 : gnd;
    assign _100 = _38 ? _52 : _99;
    assign _101 = _34 ? _52 : _100;
    assign _102 = _28 ? _101 : _52;
    assign _12 = _102;
    always @(posedge _18) begin
        if (_16)
            _52 <= _69;
        else
            _52 <= _12;
    end
    assign gnd = 1'b0;
    assign _104 = _103 ? vdd : gnd;
    assign _105 = _38 ? _50 : _104;
    assign _106 = _34 ? _50 : _105;
    assign _107 = _28 ? _106 : _50;
    assign _13 = _107;
    always @(posedge _18) begin
        if (_16)
            _50 <= _69;
        else
            _50 <= _13;
    end
    bcd
        bcd
        ( .clock(_18),
          .reset(_16),
          .convert(_50),
          .start_value(_32),
          .increment(_52),
          .ready(_53[0:0]),
          .bcd_value(_53[40:1]),
          .int_value(_53[73:41]),
          .num_digits(_53[78:74]),
          .is_invalid(_53[79:79]) );
    assign _54 = _53[0:0];
    assign _55 = _54 == vdd;
    assign _58 = _55 & _57;
    assign _114 = _58 ? _113 : range_counter;
    assign _111 = _109 ? _33 : range_counter;
    assign _115 = _48 ? _114 : _111;
    assign _116 = _42 ? _115 : range_counter;
    assign _117 = _38 ? range_counter : _116;
    assign _118 = _34 ? range_counter : _117;
    assign _119 = _28 ? _118 : range_counter;
    assign _14 = _119;
    always @(posedge _18) begin
        if (_16)
            range_counter <= _33;
        else
            range_counter <= _14;
    end
    assign _16 = reset;
    assign _18 = clock;
    assign _120 = _36 - _32;
    assign _122 = _120 + _112;
    assign _123 = _38 ? range : _122;
    assign _124 = _34 ? range : _123;
    assign _125 = _28 ? _124 : range;
    assign _19 = _125;
    always @(posedge _18) begin
        if (_16)
            range <= _33;
        else
            range <= _19;
    end
    assign _47 = range < range_counter;
    assign _48 = ~ _47;
    assign _128 = _48 ? _126 : _127;
    assign vdd = 1'b1;
    assign _103 = ~ _40;
    assign _126 = _103 ? vdd : _40;
    assign _129 = _42 ? _128 : _126;
    assign _130 = _38 ? _40 : _129;
    assign _131 = _34 ? _40 : _130;
    assign _132 = _28 ? _131 : _40;
    assign _20 = _132;
    always @(posedge _18) begin
        if (_16)
            _40 <= _69;
        else
            _40 <= _20;
    end
    assign _42 = _40 == vdd;
    assign _136 = _42 ? _135 : _36;
    assign _139 = _38 ? _138 : _136;
    assign _140 = _34 ? _36 : _139;
    assign _141 = _28 ? _140 : _36;
    assign _21 = _141;
    always @(posedge _18) begin
        if (_16)
            _36 <= _33;
        else
            _36 <= _21;
    end
    assign _38 = _36 == _33;
    assign _146 = _38 ? _32 : _145;
    assign _149 = _34 ? _148 : _146;
    assign _150 = _28 ? _149 : _32;
    assign _22 = _150;
    always @(posedge _18) begin
        if (_16)
            _32 <= _33;
        else
            _32 <= _22;
    end
    assign _34 = _32 == _33;
    assign _154 = _34 ? _109 : _153;
    assign _27 = 5'b00100;
    assign _24 = puzzle;
    assign _28 = _24 == _27;
    assign _155 = _28 ? _154 : _109;
    assign _25 = _155;
    always @(posedge _18) begin
        if (_16)
            _109 <= _69;
        else
            _109 <= _25;
    end
    assign result$valid = _109;
    assign result$value = _91;
    assign data_ready = _70;
    assign debug = _30;

endmodule
module aoc_top (
    puzzle,
    data$value,
    data$valid,
    reset,
    clock,
    result$valid,
    result$value,
    data_ready,
    debug
);

    input [4:0] puzzle;
    input [63:0] data$value;
    input data$valid;
    input reset;
    input clock;
    output result$valid;
    output [63:0] result$value;
    output data_ready;
    output [1:0] debug;

    wire [1:0] _16;
    wire _17;
    wire [63:0] _18;
    wire [4:0] _5;
    wire [63:0] _7;
    wire _9;
    wire _11;
    wire _13;
    wire [67:0] _15;
    wire _19;
    assign _16 = _15[67:66];
    assign _17 = _15[65:65];
    assign _18 = _15[64:1];
    assign _5 = puzzle;
    assign _7 = data$value;
    assign _9 = data$valid;
    assign _11 = reset;
    assign _13 = clock;
    aoc
        aoc
        ( .clock(_13),
          .reset(_11),
          .data$valid(_9),
          .data$value(_7),
          .puzzle(_5),
          .result$valid(_15[0:0]),
          .result$value(_15[64:1]),
          .data_ready(_15[65:65]),
          .debug(_15[67:66]) );
    assign _19 = _15[0:0];
    assign result$valid = _19;
    assign result$value = _18;
    assign data_ready = _17;
    assign debug = _16;

endmodule

