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
use ieee.numeric_std.all;
library work;
use work.spiker_pkg.all;


entity full_accelerator is
    generic (
        n_cycles : integer := 10;
        cycles_cnt_bitwidth : integer := 5
    );
    port (
        clk : in std_logic;
        rst_n : in std_logic;
        start : in std_logic;
        sample_ready : in std_logic;
        ready : out std_logic;
        sample : out std_logic;
        in_spike : in std_logic;
        in_spike_addr : in std_logic_vector(9 downto 0);
        out_spike : out std_logic;
        out_spike_addr : in std_logic_vector(3 downto 0)
    );
end entity full_accelerator;

architecture behavior of full_accelerator is


    component network is
        generic (
            n_cycles : integer := 10;
            cycles_cnt_bitwidth : integer := 5
        );
        port (
            clk : in std_logic;
            rst_n : in std_logic;
            start : in std_logic;
            sample_ready : in std_logic;
            ready : out std_logic;
            sample : out std_logic;
            in_spikes : in std_logic_vector(783 downto 0);
            out_spikes : out std_logic_vector(9 downto 0)
        );
    end component;

    component decoder is
        generic (
            bitwidth : integer := 10
        );
        port (
            encoded_in : in std_logic_vector(bitwidth-1 downto 0);
            decoded_out : out std_logic_vector(2**bitwidth-1 downto 0)
        );
    end component;

    component mux_16to1 is
        port (
            mux_sel : in std_logic_vector(3 downto 0);
            in0 : in std_logic;
            in1 : in std_logic;
            in2 : in std_logic;
            in3 : in std_logic;
            in4 : in std_logic;
            in5 : in std_logic;
            in6 : in std_logic;
            in7 : in std_logic;
            in8 : in std_logic;
            in9 : in std_logic;
            in10 : in std_logic;
            in11 : in std_logic;
            in12 : in std_logic;
            in13 : in std_logic;
            in14 : in std_logic;
            in15 : in std_logic;
            mux_out : out std_logic
        );
    end component;

    component reg is
        port (
            clk : in std_logic;
            en : in std_logic;
            reg_in : in std_logic;
            reg_out : out std_logic
        );
    end component;


    signal en : std_logic_vector(1023 downto 0);
    signal in_spikes : std_logic_vector(1023 downto 0);
    signal out_spikes : std_logic_vector(9 downto 0);

begin

    spikes : for i in 0 to 783
    generate
        spike_reg_i : reg
            port map(
                clk => clk,
                en => en(i),
                reg_in => in_spike,
                reg_out => in_spikes(i)
            );



    end generate spikes;



    input_decoder : decoder
        generic map(
            bitwidth => 10
        )
        port map(
            encoded_in => in_spike_addr,
            decoded_out => en
        );

    output_mux : mux_16to1
        port map(
            mux_sel => out_spike_addr,
            in0 => out_spikes(0),
            in1 => out_spikes(1),
            in2 => out_spikes(2),
            in3 => out_spikes(3),
            in4 => out_spikes(4),
            in5 => out_spikes(5),
            in6 => out_spikes(6),
            in7 => out_spikes(7),
            in8 => out_spikes(8),
            in9 => out_spikes(9),
            in10 => '0',
            in11 => '0',
            in12 => '0',
            in13 => '0',
            in14 => '0',
            in15 => '0',
            mux_out => out_spike
        );

    snn : network
        generic map(
            n_cycles => n_cycles,
            cycles_cnt_bitwidth => cycles_cnt_bitwidth
        )
        port map(
            clk => clk,
            rst_n => rst_n,
            start => start,
            sample_ready => sample_ready,
            ready => ready,
            sample => sample,
            in_spikes => in_spikes(783 downto 0),
            out_spikes => out_spikes
        );


end architecture behavior;

