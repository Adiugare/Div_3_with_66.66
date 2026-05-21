# div3_66 — Divide-by-3 Clock Divider (66% Duty Cycle)

## Overview

`div3_66` is a synchronous, reset-able clock divider written in Verilog. It divides an input clock by **3** and produces an output clock (`clk_out`) with a **66.7% duty cycle** — high for 2 input clock cycles, low for 1.

---

## Module: `div3_66`

### Ports

| Port      | Direction | Width | Description                          |
|-----------|-----------|-------|--------------------------------------|
| `clk`     | Input     | 1-bit | Source clock                         |
| `rst`     | Input     | 1-bit | Synchronous active-high reset        |
| `clk_out` | Output    | 1-bit | Divided clock (fin/3, 66% duty cycle)|

### Parameters / Internals

| Signal | Width  | Description                              |
|--------|--------|------------------------------------------|
| `cnt`  | 2-bit  | Modulo-3 counter (cycles through 0→1→2) |

### Functional Description

The module uses a 2-bit modulo-3 counter (`cnt`) clocked on the **rising edge** of `clk`:

| `cnt` value | `clk_out` |
|:-----------:|:---------:|
| 0           | 1         |
| 1           | 1         |
| 2           | 0         |

- Counter wraps: `0 → 1 → 2 → 0 → ...`
- Output is **HIGH** for 2 out of every 3 input clock cycles → **66.7% duty cycle**
- On `rst = 1`: counter and output are both cleared to `0`

### Timing Diagram

```
clk     : _|‾|_|‾|_|‾|_|‾|_|‾|_|‾|_
rst     : ‾‾‾‾|_______________________
cnt     :  0   0  1  2  0  1  2  0
clk_out : _______|‾‾‾‾‾‾‾|_|‾‾‾‾‾‾‾|_
```

> After reset de-asserts, `clk_out` goes high for 2 cycles, low for 1, repeating.

---

## Testbench: `div3_66_tb`

### Description

The testbench (`div3_66_tb`) instantiates `div3_66` as the DUT and verifies correct divide-by-3 behaviour with a 66% duty cycle output.

### Clock & Stimulus

| Parameter        | Value              |
|------------------|--------------------|
| Clock period     | 10 ns (`#5` toggle)|
| Reset assert     | t = 0 ns           |
| Reset de-assert  | t = 20 ns          |
| Simulation end   | t = 170 ns         |

### Features

- **`$monitor`** — prints `TIME`, `rst`, `clk`, `cnt`, and `clk_out` on every signal change
- **`$dumpfile` / `$dumpvars`** — generates `div3_66.vcd` for waveform viewing in GTKWave or similar

---

## File Structure

```
.
├── div3_66.v          # RTL source — clock divider module
├── div3_66_tb.v       # Testbench
├── div3_66.vcd        # Waveform dump (generated after simulation)
└── README.md          # This file
```

---

## Simulation

### Using Icarus Verilog

```bash
# Compile
iverilog -o div3_66_sim div3_66.v div3_66_tb.v

# Run
vvp div3_66_sim

# View waveform
gtkwave div3_66.vcd
```

### Using ModelSim / Questa

```tcl
vlog div3_66.v div3_66_tb.v
vsim div3_66_tb
run -all
```

### Expected Console Output (excerpt)

```
TIME=0  rst=1 clk=0 cnt=0 clk_out=0
TIME=5  rst=1 clk=1 cnt=0 clk_out=0
TIME=20 rst=0 clk=0 cnt=0 clk_out=0
TIME=25 rst=0 clk=1 cnt=0 clk_out=1
TIME=35 rst=0 clk=1 cnt=1 clk_out=1
TIME=45 rst=0 clk=1 cnt=2 clk_out=0
TIME=55 rst=0 clk=1 cnt=0 clk_out=1
...
```

---

## Synthesis Notes

- Targets any FPGA or ASIC flow with standard synchronous reset support
- The 2-bit counter synthesizes to **2 flip-flops** and a small combinational block
- `clk_out` is a **registered output** — glitch-free by design
- For use as a clock source in downstream logic, instantiate a **BUFG** (Xilinx) or **CLKBUF** (Intel) on `clk_out` to route it on the clock network

---

## License

This project is released under the [MIT License](LICENSE).
