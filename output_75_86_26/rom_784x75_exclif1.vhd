---------------------------------------------------------------------------------
-- This is free and unencumbered software released into the public domain.
--
-- Anyone is free to copy, modify, publish, use, compile, sell, or
-- distribute this software, either in source code form or as a compiled
-- binary, for any purpose, commercial or non-commercial, and by any
-- means.
--
-- In jurisdictions that recognize copyright laws, the author or authors
-- of this software dedicate any and all copyright interest in the
-- software to the public domain. We make this dedication for the benefit
-- of the public at large and to the detriment of our heirs and
-- successors. We intend this dedication to be an overt act of
-- relinquishment in perpetuity of all present and future rights to this
-- software under copyright law.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
-- EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
-- MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
-- IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
-- OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
-- ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
-- OTHER DEALINGS IN THE SOFTWARE.
--
-- For more information, please refer to <http://unlicense.org/>
---------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;


entity rom_784x75_exclif1 is
    port (
        clka : in std_logic;
        addra : in std_logic_vector(9 downto 0);
        dout_0 : out std_logic_vector(5 downto 0);
        dout_1 : out std_logic_vector(5 downto 0);
        dout_2 : out std_logic_vector(5 downto 0);
        dout_3 : out std_logic_vector(5 downto 0);
        dout_4 : out std_logic_vector(5 downto 0);
        dout_5 : out std_logic_vector(5 downto 0);
        dout_6 : out std_logic_vector(5 downto 0);
        dout_7 : out std_logic_vector(5 downto 0);
        dout_8 : out std_logic_vector(5 downto 0);
        dout_9 : out std_logic_vector(5 downto 0);
        dout_a : out std_logic_vector(5 downto 0);
        dout_b : out std_logic_vector(5 downto 0);
        dout_c : out std_logic_vector(5 downto 0);
        dout_d : out std_logic_vector(5 downto 0);
        dout_e : out std_logic_vector(5 downto 0);
        dout_f : out std_logic_vector(5 downto 0);
        dout_10 : out std_logic_vector(5 downto 0);
        dout_11 : out std_logic_vector(5 downto 0);
        dout_12 : out std_logic_vector(5 downto 0);
        dout_13 : out std_logic_vector(5 downto 0);
        dout_14 : out std_logic_vector(5 downto 0);
        dout_15 : out std_logic_vector(5 downto 0);
        dout_16 : out std_logic_vector(5 downto 0);
        dout_17 : out std_logic_vector(5 downto 0);
        dout_18 : out std_logic_vector(5 downto 0);
        dout_19 : out std_logic_vector(5 downto 0);
        dout_1a : out std_logic_vector(5 downto 0);
        dout_1b : out std_logic_vector(5 downto 0);
        dout_1c : out std_logic_vector(5 downto 0);
        dout_1d : out std_logic_vector(5 downto 0);
        dout_1e : out std_logic_vector(5 downto 0);
        dout_1f : out std_logic_vector(5 downto 0);
        dout_20 : out std_logic_vector(5 downto 0);
        dout_21 : out std_logic_vector(5 downto 0);
        dout_22 : out std_logic_vector(5 downto 0);
        dout_23 : out std_logic_vector(5 downto 0);
        dout_24 : out std_logic_vector(5 downto 0);
        dout_25 : out std_logic_vector(5 downto 0);
        dout_26 : out std_logic_vector(5 downto 0);
        dout_27 : out std_logic_vector(5 downto 0);
        dout_28 : out std_logic_vector(5 downto 0);
        dout_29 : out std_logic_vector(5 downto 0);
        dout_2a : out std_logic_vector(5 downto 0);
        dout_2b : out std_logic_vector(5 downto 0);
        dout_2c : out std_logic_vector(5 downto 0);
        dout_2d : out std_logic_vector(5 downto 0);
        dout_2e : out std_logic_vector(5 downto 0);
        dout_2f : out std_logic_vector(5 downto 0);
        dout_30 : out std_logic_vector(5 downto 0);
        dout_31 : out std_logic_vector(5 downto 0);
        dout_32 : out std_logic_vector(5 downto 0);
        dout_33 : out std_logic_vector(5 downto 0);
        dout_34 : out std_logic_vector(5 downto 0);
        dout_35 : out std_logic_vector(5 downto 0);
        dout_36 : out std_logic_vector(5 downto 0);
        dout_37 : out std_logic_vector(5 downto 0);
        dout_38 : out std_logic_vector(5 downto 0);
        dout_39 : out std_logic_vector(5 downto 0);
        dout_3a : out std_logic_vector(5 downto 0);
        dout_3b : out std_logic_vector(5 downto 0);
        dout_3c : out std_logic_vector(5 downto 0);
        dout_3d : out std_logic_vector(5 downto 0);
        dout_3e : out std_logic_vector(5 downto 0);
        dout_3f : out std_logic_vector(5 downto 0);
        dout_40 : out std_logic_vector(5 downto 0);
        dout_41 : out std_logic_vector(5 downto 0);
        dout_42 : out std_logic_vector(5 downto 0);
        dout_43 : out std_logic_vector(5 downto 0);
        dout_44 : out std_logic_vector(5 downto 0);
        dout_45 : out std_logic_vector(5 downto 0);
        dout_46 : out std_logic_vector(5 downto 0);
        dout_47 : out std_logic_vector(5 downto 0);
        dout_48 : out std_logic_vector(5 downto 0);
        dout_49 : out std_logic_vector(5 downto 0);
        dout_4a : out std_logic_vector(5 downto 0)
    );
end entity rom_784x75_exclif1;

architecture behavior of rom_784x75_exclif1 is


    component rom_784x75_exclif1_ip is
        port (
            clka : in std_logic;
            addra : in std_logic_vector(9 downto 0);
            douta : out std_logic_vector(449 downto 0)
        );
    end component;


    signal douta : std_logic_vector(449 downto 0);

begin

    dout_0 <= douta(5 downto 0);
    dout_1 <= douta(11 downto 6);
    dout_2 <= douta(17 downto 12);
    dout_3 <= douta(23 downto 18);
    dout_4 <= douta(29 downto 24);
    dout_5 <= douta(35 downto 30);
    dout_6 <= douta(41 downto 36);
    dout_7 <= douta(47 downto 42);
    dout_8 <= douta(53 downto 48);
    dout_9 <= douta(59 downto 54);
    dout_a <= douta(65 downto 60);
    dout_b <= douta(71 downto 66);
    dout_c <= douta(77 downto 72);
    dout_d <= douta(83 downto 78);
    dout_e <= douta(89 downto 84);
    dout_f <= douta(95 downto 90);
    dout_10 <= douta(101 downto 96);
    dout_11 <= douta(107 downto 102);
    dout_12 <= douta(113 downto 108);
    dout_13 <= douta(119 downto 114);
    dout_14 <= douta(125 downto 120);
    dout_15 <= douta(131 downto 126);
    dout_16 <= douta(137 downto 132);
    dout_17 <= douta(143 downto 138);
    dout_18 <= douta(149 downto 144);
    dout_19 <= douta(155 downto 150);
    dout_1a <= douta(161 downto 156);
    dout_1b <= douta(167 downto 162);
    dout_1c <= douta(173 downto 168);
    dout_1d <= douta(179 downto 174);
    dout_1e <= douta(185 downto 180);
    dout_1f <= douta(191 downto 186);
    dout_20 <= douta(197 downto 192);
    dout_21 <= douta(203 downto 198);
    dout_22 <= douta(209 downto 204);
    dout_23 <= douta(215 downto 210);
    dout_24 <= douta(221 downto 216);
    dout_25 <= douta(227 downto 222);
    dout_26 <= douta(233 downto 228);
    dout_27 <= douta(239 downto 234);
    dout_28 <= douta(245 downto 240);
    dout_29 <= douta(251 downto 246);
    dout_2a <= douta(257 downto 252);
    dout_2b <= douta(263 downto 258);
    dout_2c <= douta(269 downto 264);
    dout_2d <= douta(275 downto 270);
    dout_2e <= douta(281 downto 276);
    dout_2f <= douta(287 downto 282);
    dout_30 <= douta(293 downto 288);
    dout_31 <= douta(299 downto 294);
    dout_32 <= douta(305 downto 300);
    dout_33 <= douta(311 downto 306);
    dout_34 <= douta(317 downto 312);
    dout_35 <= douta(323 downto 318);
    dout_36 <= douta(329 downto 324);
    dout_37 <= douta(335 downto 330);
    dout_38 <= douta(341 downto 336);
    dout_39 <= douta(347 downto 342);
    dout_3a <= douta(353 downto 348);
    dout_3b <= douta(359 downto 354);
    dout_3c <= douta(365 downto 360);
    dout_3d <= douta(371 downto 366);
    dout_3e <= douta(377 downto 372);
    dout_3f <= douta(383 downto 378);
    dout_40 <= douta(389 downto 384);
    dout_41 <= douta(395 downto 390);
    dout_42 <= douta(401 downto 396);
    dout_43 <= douta(407 downto 402);
    dout_44 <= douta(413 downto 408);
    dout_45 <= douta(419 downto 414);
    dout_46 <= douta(425 downto 420);
    dout_47 <= douta(431 downto 426);
    dout_48 <= douta(437 downto 432);
    dout_49 <= douta(443 downto 438);
    dout_4a <= douta(449 downto 444);


    rom_784x75_exclif1_ip_instance : rom_784x75_exclif1_ip
        port map(
            clka => clka,
            addra => addra,
            douta => douta
        );


end architecture behavior;

