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


entity layer_75_neurons_784_inputs is
    generic (
        n_exc_inputs : integer := 784;
        n_inh_inputs : integer := 75;
        exc_cnt_bitwidth : integer := 10;
        inh_cnt_bitwidth : integer := 7;
        neuron_bit_width : integer := 9;
        inh_weights_bit_width : integer := 6;
        exc_weights_bit_width : integer := 6;
        shift : integer := 4
    );
    port (
        clk : in std_logic;
        rst_n : in std_logic;
        start : in std_logic;
        restart : in std_logic;
        exc_spikes : in std_logic_vector(n_exc_inputs-1 downto 0);
        inh_spikes : in std_logic_vector(n_inh_inputs-1 downto 0);
        ready : out std_logic;
        out_spikes : out std_logic_vector(74 downto 0)
    );
end entity layer_75_neurons_784_inputs;

architecture behavior of layer_75_neurons_784_inputs is


    constant v_th_0 : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_1 : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_2 : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_3 : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_4 : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_5 : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_6 : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_7 : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_8 : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_9 : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_a : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_b : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_c : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_d : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_e : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_f : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_10 : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_11 : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_12 : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_13 : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_14 : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_15 : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_16 : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_17 : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_18 : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_19 : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_1a : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_1b : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_1c : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_1d : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_1e : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_1f : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_20 : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_21 : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_22 : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_23 : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_24 : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_25 : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_26 : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_27 : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_28 : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_29 : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_2a : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_2b : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_2c : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_2d : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_2e : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_2f : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_30 : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_31 : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_32 : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_33 : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_34 : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_35 : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_36 : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_37 : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_38 : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_39 : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_3a : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_3b : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_3c : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_3d : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_3e : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_3f : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_40 : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_41 : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_42 : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_43 : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_44 : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_45 : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_46 : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_47 : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_48 : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_49 : signed(neuron_bit_width-1 downto 0) := "000100000";
    constant v_th_4a : signed(neuron_bit_width-1 downto 0) := "000100000";

    component multi_input_784_exc_75_inh is
        generic (
            n_exc_inputs : integer := 784;
            n_inh_inputs : integer := 75;
            exc_cnt_bitwidth : integer := 10;
            inh_cnt_bitwidth : integer := 7
        );
        port (
            clk : in std_logic;
            rst_n : in std_logic;
            restart : in std_logic;
            start : in std_logic;
            exc_spikes : in std_logic_vector(n_exc_inputs-1 downto 0);
            inh_spikes : in std_logic_vector(n_inh_inputs-1 downto 0);
            neurons_ready : in std_logic;
            exc_cnt : out std_logic_vector(exc_cnt_bitwidth - 1 downto 0);
            inh_cnt : out std_logic_vector(inh_cnt_bitwidth - 1 downto 0);
            ready : out std_logic;
            neuron_restart : out std_logic;
            exc : out std_logic;
            inh : out std_logic;
            out_sample : out std_logic;
            exc_spike : out std_logic;
            inh_spike : out std_logic
        );
    end component;

    component neuron_subtractive is
        generic (
            neuron_bit_width : integer := 9;
            inh_weights_bit_width : integer := 6;
            exc_weights_bit_width : integer := 6;
            shift : integer := 4
        );
        port (
            v_th : in signed(neuron_bit_width-1 downto 0);
            inh_weight : in signed(inh_weights_bit_width-1 downto 0);
            exc_weight : in signed(exc_weights_bit_width-1 downto 0);
            clk : in std_logic;
            rst_n : in std_logic;
            restart : in std_logic;
            exc : in std_logic;
            inh : in std_logic;
            exc_spike : in std_logic;
            inh_spike : in std_logic;
            neuron_ready : out std_logic;
            out_spike : out std_logic
        );
    end component;

    component rom_784x75_exclif1 is
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
    end component;

    component rom_75x75_inhlif1 is
        port (
            clka : in std_logic;
            addra : in std_logic_vector(6 downto 0);
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
    end component;

    component addr_converter is
        generic (
            N : integer := 10
        );
        port (
            addr_in : in std_logic_vector(N-1 downto 0);
            addr_out : out std_logic_vector(N-1 downto 0)
        );
    end component;

    component barrier is
        generic (
            N : integer := 75
        );
        port (
            clk : in std_logic;
            rst_n : in std_logic;
            restart : in std_logic;
            out_sample : in std_logic;
            reg_in : in std_logic_vector(N-1 downto 0);
            ready : out std_logic;
            reg_out : out std_logic_vector(N-1 downto 0)
        );
    end component;


    signal start_neurons : std_logic;
    signal neurons_restart : std_logic;
    signal neurons_ready : std_logic;
    signal exc : std_logic;
    signal inh : std_logic;
    signal exc_spike : std_logic;
    signal inh_spike : std_logic;
    signal exc_cnt : std_logic_vector(exc_cnt_bitwidth - 1 downto 0);
    signal inh_cnt : std_logic_vector(inh_cnt_bitwidth - 1 downto 0);
    signal exc_addr : std_logic_vector(exc_cnt_bitwidth - 1 downto 0);
    signal inh_addr : std_logic_vector(inh_cnt_bitwidth - 1 downto 0);
    signal neuron_restart : std_logic;
    signal barrier_ready : std_logic;
    signal out_spikes_inst : std_logic_vector(74 downto 0);
    signal out_sample : std_logic;
    signal neuron_ready_0 : std_logic;
    signal inh_weight_0 : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_0 : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_1 : std_logic;
    signal inh_weight_1 : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_1 : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_2 : std_logic;
    signal inh_weight_2 : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_2 : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_3 : std_logic;
    signal inh_weight_3 : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_3 : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_4 : std_logic;
    signal inh_weight_4 : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_4 : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_5 : std_logic;
    signal inh_weight_5 : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_5 : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_6 : std_logic;
    signal inh_weight_6 : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_6 : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_7 : std_logic;
    signal inh_weight_7 : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_7 : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_8 : std_logic;
    signal inh_weight_8 : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_8 : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_9 : std_logic;
    signal inh_weight_9 : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_9 : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_a : std_logic;
    signal inh_weight_a : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_a : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_b : std_logic;
    signal inh_weight_b : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_b : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_c : std_logic;
    signal inh_weight_c : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_c : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_d : std_logic;
    signal inh_weight_d : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_d : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_e : std_logic;
    signal inh_weight_e : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_e : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_f : std_logic;
    signal inh_weight_f : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_f : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_10 : std_logic;
    signal inh_weight_10 : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_10 : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_11 : std_logic;
    signal inh_weight_11 : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_11 : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_12 : std_logic;
    signal inh_weight_12 : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_12 : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_13 : std_logic;
    signal inh_weight_13 : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_13 : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_14 : std_logic;
    signal inh_weight_14 : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_14 : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_15 : std_logic;
    signal inh_weight_15 : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_15 : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_16 : std_logic;
    signal inh_weight_16 : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_16 : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_17 : std_logic;
    signal inh_weight_17 : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_17 : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_18 : std_logic;
    signal inh_weight_18 : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_18 : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_19 : std_logic;
    signal inh_weight_19 : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_19 : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_1a : std_logic;
    signal inh_weight_1a : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_1a : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_1b : std_logic;
    signal inh_weight_1b : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_1b : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_1c : std_logic;
    signal inh_weight_1c : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_1c : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_1d : std_logic;
    signal inh_weight_1d : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_1d : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_1e : std_logic;
    signal inh_weight_1e : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_1e : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_1f : std_logic;
    signal inh_weight_1f : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_1f : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_20 : std_logic;
    signal inh_weight_20 : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_20 : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_21 : std_logic;
    signal inh_weight_21 : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_21 : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_22 : std_logic;
    signal inh_weight_22 : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_22 : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_23 : std_logic;
    signal inh_weight_23 : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_23 : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_24 : std_logic;
    signal inh_weight_24 : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_24 : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_25 : std_logic;
    signal inh_weight_25 : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_25 : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_26 : std_logic;
    signal inh_weight_26 : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_26 : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_27 : std_logic;
    signal inh_weight_27 : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_27 : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_28 : std_logic;
    signal inh_weight_28 : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_28 : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_29 : std_logic;
    signal inh_weight_29 : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_29 : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_2a : std_logic;
    signal inh_weight_2a : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_2a : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_2b : std_logic;
    signal inh_weight_2b : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_2b : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_2c : std_logic;
    signal inh_weight_2c : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_2c : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_2d : std_logic;
    signal inh_weight_2d : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_2d : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_2e : std_logic;
    signal inh_weight_2e : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_2e : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_2f : std_logic;
    signal inh_weight_2f : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_2f : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_30 : std_logic;
    signal inh_weight_30 : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_30 : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_31 : std_logic;
    signal inh_weight_31 : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_31 : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_32 : std_logic;
    signal inh_weight_32 : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_32 : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_33 : std_logic;
    signal inh_weight_33 : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_33 : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_34 : std_logic;
    signal inh_weight_34 : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_34 : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_35 : std_logic;
    signal inh_weight_35 : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_35 : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_36 : std_logic;
    signal inh_weight_36 : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_36 : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_37 : std_logic;
    signal inh_weight_37 : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_37 : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_38 : std_logic;
    signal inh_weight_38 : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_38 : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_39 : std_logic;
    signal inh_weight_39 : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_39 : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_3a : std_logic;
    signal inh_weight_3a : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_3a : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_3b : std_logic;
    signal inh_weight_3b : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_3b : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_3c : std_logic;
    signal inh_weight_3c : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_3c : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_3d : std_logic;
    signal inh_weight_3d : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_3d : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_3e : std_logic;
    signal inh_weight_3e : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_3e : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_3f : std_logic;
    signal inh_weight_3f : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_3f : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_40 : std_logic;
    signal inh_weight_40 : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_40 : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_41 : std_logic;
    signal inh_weight_41 : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_41 : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_42 : std_logic;
    signal inh_weight_42 : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_42 : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_43 : std_logic;
    signal inh_weight_43 : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_43 : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_44 : std_logic;
    signal inh_weight_44 : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_44 : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_45 : std_logic;
    signal inh_weight_45 : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_45 : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_46 : std_logic;
    signal inh_weight_46 : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_46 : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_47 : std_logic;
    signal inh_weight_47 : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_47 : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_48 : std_logic;
    signal inh_weight_48 : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_48 : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_49 : std_logic;
    signal inh_weight_49 : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_49 : std_logic_vector(exc_weights_bit_width-1 downto 0);
    signal neuron_ready_4a : std_logic;
    signal inh_weight_4a : std_logic_vector(inh_weights_bit_width-1 downto 0);
    signal exc_weight_4a : std_logic_vector(exc_weights_bit_width-1 downto 0);

begin

    neurons_ready <= neuron_ready_0 and neuron_ready_1 and neuron_ready_2 and neuron_ready_3 and neuron_ready_4 and neuron_ready_5 and neuron_ready_6 and neuron_ready_7 and neuron_ready_8 and neuron_ready_9 and neuron_ready_a and neuron_ready_b and neuron_ready_c and neuron_ready_d and neuron_ready_e and neuron_ready_f and neuron_ready_10 and neuron_ready_11 and neuron_ready_12 and neuron_ready_13 and neuron_ready_14 and neuron_ready_15 and neuron_ready_16 and neuron_ready_17 and neuron_ready_18 and neuron_ready_19 and neuron_ready_1a and neuron_ready_1b and neuron_ready_1c and neuron_ready_1d and neuron_ready_1e and neuron_ready_1f and neuron_ready_20 and neuron_ready_21 and neuron_ready_22 and neuron_ready_23 and neuron_ready_24 and neuron_ready_25 and neuron_ready_26 and neuron_ready_27 and neuron_ready_28 and neuron_ready_29 and neuron_ready_2a and neuron_ready_2b and neuron_ready_2c and neuron_ready_2d and neuron_ready_2e and neuron_ready_2f and neuron_ready_30 and neuron_ready_31 and neuron_ready_32 and neuron_ready_33 and neuron_ready_34 and neuron_ready_35 and neuron_ready_36 and neuron_ready_37 and neuron_ready_38 and neuron_ready_39 and neuron_ready_3a and neuron_ready_3b and neuron_ready_3c and neuron_ready_3d and neuron_ready_3e and neuron_ready_3f and neuron_ready_40 and neuron_ready_41 and neuron_ready_42 and neuron_ready_43 and neuron_ready_44 and neuron_ready_45 and neuron_ready_46 and neuron_ready_47 and neuron_ready_48 and neuron_ready_49 and neuron_ready_4a and barrier_ready;


    multi_input_control : multi_input_784_exc_75_inh
        generic map(
            n_exc_inputs => n_exc_inputs,
            n_inh_inputs => n_inh_inputs,
            exc_cnt_bitwidth => exc_cnt_bitwidth,
            inh_cnt_bitwidth => inh_cnt_bitwidth
        )
        port map(
            clk => clk,
            rst_n => rst_n,
            restart => restart,
            start => start,
            exc_spikes => exc_spikes,
            inh_spikes => inh_spikes,
            neurons_ready => neurons_ready,
            exc_cnt => exc_cnt,
            inh_cnt => inh_cnt,
            ready => ready,
            neuron_restart => neuron_restart,
            exc => exc,
            inh => inh,
            out_sample => out_sample,
            exc_spike => exc_spike,
            inh_spike => inh_spike
        );

    neuron_0 : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_0,
            inh_weight => signed(inh_weight_0),
            exc_weight => signed(exc_weight_0),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_0,
            out_spike => out_spikes_inst(0)
        );

    neuron_1 : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_1,
            inh_weight => signed(inh_weight_1),
            exc_weight => signed(exc_weight_1),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_1,
            out_spike => out_spikes_inst(1)
        );

    neuron_2 : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_2,
            inh_weight => signed(inh_weight_2),
            exc_weight => signed(exc_weight_2),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_2,
            out_spike => out_spikes_inst(2)
        );

    neuron_3 : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_3,
            inh_weight => signed(inh_weight_3),
            exc_weight => signed(exc_weight_3),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_3,
            out_spike => out_spikes_inst(3)
        );

    neuron_4 : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_4,
            inh_weight => signed(inh_weight_4),
            exc_weight => signed(exc_weight_4),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_4,
            out_spike => out_spikes_inst(4)
        );

    neuron_5 : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_5,
            inh_weight => signed(inh_weight_5),
            exc_weight => signed(exc_weight_5),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_5,
            out_spike => out_spikes_inst(5)
        );

    neuron_6 : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_6,
            inh_weight => signed(inh_weight_6),
            exc_weight => signed(exc_weight_6),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_6,
            out_spike => out_spikes_inst(6)
        );

    neuron_7 : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_7,
            inh_weight => signed(inh_weight_7),
            exc_weight => signed(exc_weight_7),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_7,
            out_spike => out_spikes_inst(7)
        );

    neuron_8 : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_8,
            inh_weight => signed(inh_weight_8),
            exc_weight => signed(exc_weight_8),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_8,
            out_spike => out_spikes_inst(8)
        );

    neuron_9 : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_9,
            inh_weight => signed(inh_weight_9),
            exc_weight => signed(exc_weight_9),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_9,
            out_spike => out_spikes_inst(9)
        );

    neuron_a : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_a,
            inh_weight => signed(inh_weight_a),
            exc_weight => signed(exc_weight_a),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_a,
            out_spike => out_spikes_inst(10)
        );

    neuron_b : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_b,
            inh_weight => signed(inh_weight_b),
            exc_weight => signed(exc_weight_b),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_b,
            out_spike => out_spikes_inst(11)
        );

    neuron_c : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_c,
            inh_weight => signed(inh_weight_c),
            exc_weight => signed(exc_weight_c),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_c,
            out_spike => out_spikes_inst(12)
        );

    neuron_d : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_d,
            inh_weight => signed(inh_weight_d),
            exc_weight => signed(exc_weight_d),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_d,
            out_spike => out_spikes_inst(13)
        );

    neuron_e : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_e,
            inh_weight => signed(inh_weight_e),
            exc_weight => signed(exc_weight_e),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_e,
            out_spike => out_spikes_inst(14)
        );

    neuron_f : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_f,
            inh_weight => signed(inh_weight_f),
            exc_weight => signed(exc_weight_f),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_f,
            out_spike => out_spikes_inst(15)
        );

    neuron_10 : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_10,
            inh_weight => signed(inh_weight_10),
            exc_weight => signed(exc_weight_10),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_10,
            out_spike => out_spikes_inst(16)
        );

    neuron_11 : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_11,
            inh_weight => signed(inh_weight_11),
            exc_weight => signed(exc_weight_11),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_11,
            out_spike => out_spikes_inst(17)
        );

    neuron_12 : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_12,
            inh_weight => signed(inh_weight_12),
            exc_weight => signed(exc_weight_12),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_12,
            out_spike => out_spikes_inst(18)
        );

    neuron_13 : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_13,
            inh_weight => signed(inh_weight_13),
            exc_weight => signed(exc_weight_13),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_13,
            out_spike => out_spikes_inst(19)
        );

    neuron_14 : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_14,
            inh_weight => signed(inh_weight_14),
            exc_weight => signed(exc_weight_14),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_14,
            out_spike => out_spikes_inst(20)
        );

    neuron_15 : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_15,
            inh_weight => signed(inh_weight_15),
            exc_weight => signed(exc_weight_15),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_15,
            out_spike => out_spikes_inst(21)
        );

    neuron_16 : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_16,
            inh_weight => signed(inh_weight_16),
            exc_weight => signed(exc_weight_16),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_16,
            out_spike => out_spikes_inst(22)
        );

    neuron_17 : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_17,
            inh_weight => signed(inh_weight_17),
            exc_weight => signed(exc_weight_17),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_17,
            out_spike => out_spikes_inst(23)
        );

    neuron_18 : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_18,
            inh_weight => signed(inh_weight_18),
            exc_weight => signed(exc_weight_18),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_18,
            out_spike => out_spikes_inst(24)
        );

    neuron_19 : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_19,
            inh_weight => signed(inh_weight_19),
            exc_weight => signed(exc_weight_19),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_19,
            out_spike => out_spikes_inst(25)
        );

    neuron_1a : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_1a,
            inh_weight => signed(inh_weight_1a),
            exc_weight => signed(exc_weight_1a),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_1a,
            out_spike => out_spikes_inst(26)
        );

    neuron_1b : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_1b,
            inh_weight => signed(inh_weight_1b),
            exc_weight => signed(exc_weight_1b),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_1b,
            out_spike => out_spikes_inst(27)
        );

    neuron_1c : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_1c,
            inh_weight => signed(inh_weight_1c),
            exc_weight => signed(exc_weight_1c),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_1c,
            out_spike => out_spikes_inst(28)
        );

    neuron_1d : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_1d,
            inh_weight => signed(inh_weight_1d),
            exc_weight => signed(exc_weight_1d),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_1d,
            out_spike => out_spikes_inst(29)
        );

    neuron_1e : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_1e,
            inh_weight => signed(inh_weight_1e),
            exc_weight => signed(exc_weight_1e),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_1e,
            out_spike => out_spikes_inst(30)
        );

    neuron_1f : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_1f,
            inh_weight => signed(inh_weight_1f),
            exc_weight => signed(exc_weight_1f),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_1f,
            out_spike => out_spikes_inst(31)
        );

    neuron_20 : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_20,
            inh_weight => signed(inh_weight_20),
            exc_weight => signed(exc_weight_20),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_20,
            out_spike => out_spikes_inst(32)
        );

    neuron_21 : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_21,
            inh_weight => signed(inh_weight_21),
            exc_weight => signed(exc_weight_21),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_21,
            out_spike => out_spikes_inst(33)
        );

    neuron_22 : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_22,
            inh_weight => signed(inh_weight_22),
            exc_weight => signed(exc_weight_22),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_22,
            out_spike => out_spikes_inst(34)
        );

    neuron_23 : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_23,
            inh_weight => signed(inh_weight_23),
            exc_weight => signed(exc_weight_23),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_23,
            out_spike => out_spikes_inst(35)
        );

    neuron_24 : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_24,
            inh_weight => signed(inh_weight_24),
            exc_weight => signed(exc_weight_24),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_24,
            out_spike => out_spikes_inst(36)
        );

    neuron_25 : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_25,
            inh_weight => signed(inh_weight_25),
            exc_weight => signed(exc_weight_25),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_25,
            out_spike => out_spikes_inst(37)
        );

    neuron_26 : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_26,
            inh_weight => signed(inh_weight_26),
            exc_weight => signed(exc_weight_26),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_26,
            out_spike => out_spikes_inst(38)
        );

    neuron_27 : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_27,
            inh_weight => signed(inh_weight_27),
            exc_weight => signed(exc_weight_27),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_27,
            out_spike => out_spikes_inst(39)
        );

    neuron_28 : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_28,
            inh_weight => signed(inh_weight_28),
            exc_weight => signed(exc_weight_28),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_28,
            out_spike => out_spikes_inst(40)
        );

    neuron_29 : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_29,
            inh_weight => signed(inh_weight_29),
            exc_weight => signed(exc_weight_29),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_29,
            out_spike => out_spikes_inst(41)
        );

    neuron_2a : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_2a,
            inh_weight => signed(inh_weight_2a),
            exc_weight => signed(exc_weight_2a),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_2a,
            out_spike => out_spikes_inst(42)
        );

    neuron_2b : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_2b,
            inh_weight => signed(inh_weight_2b),
            exc_weight => signed(exc_weight_2b),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_2b,
            out_spike => out_spikes_inst(43)
        );

    neuron_2c : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_2c,
            inh_weight => signed(inh_weight_2c),
            exc_weight => signed(exc_weight_2c),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_2c,
            out_spike => out_spikes_inst(44)
        );

    neuron_2d : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_2d,
            inh_weight => signed(inh_weight_2d),
            exc_weight => signed(exc_weight_2d),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_2d,
            out_spike => out_spikes_inst(45)
        );

    neuron_2e : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_2e,
            inh_weight => signed(inh_weight_2e),
            exc_weight => signed(exc_weight_2e),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_2e,
            out_spike => out_spikes_inst(46)
        );

    neuron_2f : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_2f,
            inh_weight => signed(inh_weight_2f),
            exc_weight => signed(exc_weight_2f),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_2f,
            out_spike => out_spikes_inst(47)
        );

    neuron_30 : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_30,
            inh_weight => signed(inh_weight_30),
            exc_weight => signed(exc_weight_30),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_30,
            out_spike => out_spikes_inst(48)
        );

    neuron_31 : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_31,
            inh_weight => signed(inh_weight_31),
            exc_weight => signed(exc_weight_31),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_31,
            out_spike => out_spikes_inst(49)
        );

    neuron_32 : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_32,
            inh_weight => signed(inh_weight_32),
            exc_weight => signed(exc_weight_32),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_32,
            out_spike => out_spikes_inst(50)
        );

    neuron_33 : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_33,
            inh_weight => signed(inh_weight_33),
            exc_weight => signed(exc_weight_33),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_33,
            out_spike => out_spikes_inst(51)
        );

    neuron_34 : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_34,
            inh_weight => signed(inh_weight_34),
            exc_weight => signed(exc_weight_34),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_34,
            out_spike => out_spikes_inst(52)
        );

    neuron_35 : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_35,
            inh_weight => signed(inh_weight_35),
            exc_weight => signed(exc_weight_35),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_35,
            out_spike => out_spikes_inst(53)
        );

    neuron_36 : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_36,
            inh_weight => signed(inh_weight_36),
            exc_weight => signed(exc_weight_36),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_36,
            out_spike => out_spikes_inst(54)
        );

    neuron_37 : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_37,
            inh_weight => signed(inh_weight_37),
            exc_weight => signed(exc_weight_37),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_37,
            out_spike => out_spikes_inst(55)
        );

    neuron_38 : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_38,
            inh_weight => signed(inh_weight_38),
            exc_weight => signed(exc_weight_38),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_38,
            out_spike => out_spikes_inst(56)
        );

    neuron_39 : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_39,
            inh_weight => signed(inh_weight_39),
            exc_weight => signed(exc_weight_39),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_39,
            out_spike => out_spikes_inst(57)
        );

    neuron_3a : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_3a,
            inh_weight => signed(inh_weight_3a),
            exc_weight => signed(exc_weight_3a),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_3a,
            out_spike => out_spikes_inst(58)
        );

    neuron_3b : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_3b,
            inh_weight => signed(inh_weight_3b),
            exc_weight => signed(exc_weight_3b),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_3b,
            out_spike => out_spikes_inst(59)
        );

    neuron_3c : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_3c,
            inh_weight => signed(inh_weight_3c),
            exc_weight => signed(exc_weight_3c),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_3c,
            out_spike => out_spikes_inst(60)
        );

    neuron_3d : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_3d,
            inh_weight => signed(inh_weight_3d),
            exc_weight => signed(exc_weight_3d),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_3d,
            out_spike => out_spikes_inst(61)
        );

    neuron_3e : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_3e,
            inh_weight => signed(inh_weight_3e),
            exc_weight => signed(exc_weight_3e),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_3e,
            out_spike => out_spikes_inst(62)
        );

    neuron_3f : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_3f,
            inh_weight => signed(inh_weight_3f),
            exc_weight => signed(exc_weight_3f),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_3f,
            out_spike => out_spikes_inst(63)
        );

    neuron_40 : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_40,
            inh_weight => signed(inh_weight_40),
            exc_weight => signed(exc_weight_40),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_40,
            out_spike => out_spikes_inst(64)
        );

    neuron_41 : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_41,
            inh_weight => signed(inh_weight_41),
            exc_weight => signed(exc_weight_41),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_41,
            out_spike => out_spikes_inst(65)
        );

    neuron_42 : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_42,
            inh_weight => signed(inh_weight_42),
            exc_weight => signed(exc_weight_42),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_42,
            out_spike => out_spikes_inst(66)
        );

    neuron_43 : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_43,
            inh_weight => signed(inh_weight_43),
            exc_weight => signed(exc_weight_43),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_43,
            out_spike => out_spikes_inst(67)
        );

    neuron_44 : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_44,
            inh_weight => signed(inh_weight_44),
            exc_weight => signed(exc_weight_44),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_44,
            out_spike => out_spikes_inst(68)
        );

    neuron_45 : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_45,
            inh_weight => signed(inh_weight_45),
            exc_weight => signed(exc_weight_45),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_45,
            out_spike => out_spikes_inst(69)
        );

    neuron_46 : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_46,
            inh_weight => signed(inh_weight_46),
            exc_weight => signed(exc_weight_46),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_46,
            out_spike => out_spikes_inst(70)
        );

    neuron_47 : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_47,
            inh_weight => signed(inh_weight_47),
            exc_weight => signed(exc_weight_47),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_47,
            out_spike => out_spikes_inst(71)
        );

    neuron_48 : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_48,
            inh_weight => signed(inh_weight_48),
            exc_weight => signed(exc_weight_48),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_48,
            out_spike => out_spikes_inst(72)
        );

    neuron_49 : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_49,
            inh_weight => signed(inh_weight_49),
            exc_weight => signed(exc_weight_49),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_49,
            out_spike => out_spikes_inst(73)
        );

    neuron_4a : neuron_subtractive
        generic map(
            neuron_bit_width => neuron_bit_width,
            inh_weights_bit_width => inh_weights_bit_width,
            exc_weights_bit_width => exc_weights_bit_width,
            shift => shift
        )
        port map(
            v_th => v_th_4a,
            inh_weight => signed(inh_weight_4a),
            exc_weight => signed(exc_weight_4a),
            clk => clk,
            rst_n => rst_n,
            restart => neuron_restart,
            exc => exc,
            inh => inh,
            exc_spike => exc_spike,
            inh_spike => inh_spike,
            neuron_ready => neuron_ready_4a,
            out_spike => out_spikes_inst(74)
        );

    exc_mem : rom_784x75_exclif1
        port map(
            clka => clk,
            addra => exc_addr,
            dout_0 => exc_weight_0,
            dout_1 => exc_weight_1,
            dout_2 => exc_weight_2,
            dout_3 => exc_weight_3,
            dout_4 => exc_weight_4,
            dout_5 => exc_weight_5,
            dout_6 => exc_weight_6,
            dout_7 => exc_weight_7,
            dout_8 => exc_weight_8,
            dout_9 => exc_weight_9,
            dout_a => exc_weight_a,
            dout_b => exc_weight_b,
            dout_c => exc_weight_c,
            dout_d => exc_weight_d,
            dout_e => exc_weight_e,
            dout_f => exc_weight_f,
            dout_10 => exc_weight_10,
            dout_11 => exc_weight_11,
            dout_12 => exc_weight_12,
            dout_13 => exc_weight_13,
            dout_14 => exc_weight_14,
            dout_15 => exc_weight_15,
            dout_16 => exc_weight_16,
            dout_17 => exc_weight_17,
            dout_18 => exc_weight_18,
            dout_19 => exc_weight_19,
            dout_1a => exc_weight_1a,
            dout_1b => exc_weight_1b,
            dout_1c => exc_weight_1c,
            dout_1d => exc_weight_1d,
            dout_1e => exc_weight_1e,
            dout_1f => exc_weight_1f,
            dout_20 => exc_weight_20,
            dout_21 => exc_weight_21,
            dout_22 => exc_weight_22,
            dout_23 => exc_weight_23,
            dout_24 => exc_weight_24,
            dout_25 => exc_weight_25,
            dout_26 => exc_weight_26,
            dout_27 => exc_weight_27,
            dout_28 => exc_weight_28,
            dout_29 => exc_weight_29,
            dout_2a => exc_weight_2a,
            dout_2b => exc_weight_2b,
            dout_2c => exc_weight_2c,
            dout_2d => exc_weight_2d,
            dout_2e => exc_weight_2e,
            dout_2f => exc_weight_2f,
            dout_30 => exc_weight_30,
            dout_31 => exc_weight_31,
            dout_32 => exc_weight_32,
            dout_33 => exc_weight_33,
            dout_34 => exc_weight_34,
            dout_35 => exc_weight_35,
            dout_36 => exc_weight_36,
            dout_37 => exc_weight_37,
            dout_38 => exc_weight_38,
            dout_39 => exc_weight_39,
            dout_3a => exc_weight_3a,
            dout_3b => exc_weight_3b,
            dout_3c => exc_weight_3c,
            dout_3d => exc_weight_3d,
            dout_3e => exc_weight_3e,
            dout_3f => exc_weight_3f,
            dout_40 => exc_weight_40,
            dout_41 => exc_weight_41,
            dout_42 => exc_weight_42,
            dout_43 => exc_weight_43,
            dout_44 => exc_weight_44,
            dout_45 => exc_weight_45,
            dout_46 => exc_weight_46,
            dout_47 => exc_weight_47,
            dout_48 => exc_weight_48,
            dout_49 => exc_weight_49,
            dout_4a => exc_weight_4a
        );

    exc_addr_conv : addr_converter
        generic map(
            N => exc_cnt_bitwidth
        )
        port map(
            addr_in => exc_cnt,
            addr_out => exc_addr
        );

    inh_mem : rom_75x75_inhlif1
        port map(
            clka => clk,
            addra => inh_addr,
            dout_0 => inh_weight_0,
            dout_1 => inh_weight_1,
            dout_2 => inh_weight_2,
            dout_3 => inh_weight_3,
            dout_4 => inh_weight_4,
            dout_5 => inh_weight_5,
            dout_6 => inh_weight_6,
            dout_7 => inh_weight_7,
            dout_8 => inh_weight_8,
            dout_9 => inh_weight_9,
            dout_a => inh_weight_a,
            dout_b => inh_weight_b,
            dout_c => inh_weight_c,
            dout_d => inh_weight_d,
            dout_e => inh_weight_e,
            dout_f => inh_weight_f,
            dout_10 => inh_weight_10,
            dout_11 => inh_weight_11,
            dout_12 => inh_weight_12,
            dout_13 => inh_weight_13,
            dout_14 => inh_weight_14,
            dout_15 => inh_weight_15,
            dout_16 => inh_weight_16,
            dout_17 => inh_weight_17,
            dout_18 => inh_weight_18,
            dout_19 => inh_weight_19,
            dout_1a => inh_weight_1a,
            dout_1b => inh_weight_1b,
            dout_1c => inh_weight_1c,
            dout_1d => inh_weight_1d,
            dout_1e => inh_weight_1e,
            dout_1f => inh_weight_1f,
            dout_20 => inh_weight_20,
            dout_21 => inh_weight_21,
            dout_22 => inh_weight_22,
            dout_23 => inh_weight_23,
            dout_24 => inh_weight_24,
            dout_25 => inh_weight_25,
            dout_26 => inh_weight_26,
            dout_27 => inh_weight_27,
            dout_28 => inh_weight_28,
            dout_29 => inh_weight_29,
            dout_2a => inh_weight_2a,
            dout_2b => inh_weight_2b,
            dout_2c => inh_weight_2c,
            dout_2d => inh_weight_2d,
            dout_2e => inh_weight_2e,
            dout_2f => inh_weight_2f,
            dout_30 => inh_weight_30,
            dout_31 => inh_weight_31,
            dout_32 => inh_weight_32,
            dout_33 => inh_weight_33,
            dout_34 => inh_weight_34,
            dout_35 => inh_weight_35,
            dout_36 => inh_weight_36,
            dout_37 => inh_weight_37,
            dout_38 => inh_weight_38,
            dout_39 => inh_weight_39,
            dout_3a => inh_weight_3a,
            dout_3b => inh_weight_3b,
            dout_3c => inh_weight_3c,
            dout_3d => inh_weight_3d,
            dout_3e => inh_weight_3e,
            dout_3f => inh_weight_3f,
            dout_40 => inh_weight_40,
            dout_41 => inh_weight_41,
            dout_42 => inh_weight_42,
            dout_43 => inh_weight_43,
            dout_44 => inh_weight_44,
            dout_45 => inh_weight_45,
            dout_46 => inh_weight_46,
            dout_47 => inh_weight_47,
            dout_48 => inh_weight_48,
            dout_49 => inh_weight_49,
            dout_4a => inh_weight_4a
        );

    inh_addr_conv : addr_converter
        generic map(
            N => inh_cnt_bitwidth
        )
        port map(
            addr_in => inh_cnt,
            addr_out => inh_addr
        );

    spikes_barrier : barrier
        generic map(
            N => 75
        )
        port map(
            clk => clk,
            rst_n => rst_n,
            restart => restart,
            out_sample => out_sample,
            reg_in => out_spikes_inst,
            ready => barrier_ready,
            reg_out => out_spikes
        );


end architecture behavior;

