namespace eval Numbers {
    namespace export sum_of_first_n_rec factorial_rec fibonacci_rec \
        greatest_common_divisor_rec least_common_multiple_rec \
        sum_of_first_n_acc factorial_acc fibonacci_acc \
        greatest_common_divisor_acc least_common_multiple_acc \
        sum_of_first_n_ite factorial_ite fibonacci_ite \
        greatest_common_divisor_ite least_common_multiple_ite

    proc sum_of_first_n_rec {n} {
        if {$n <= 0} {
            return 0
        }
        return [expr {$n + [sum_of_first_n_rec [expr {$n - 1}]]}]
    }

    proc factorial_rec {n} {
        if {$n <= 1} {
            return 1
        }
        return [expr {$n * [factorial_rec [expr {$n - 1}]]}]
    }

    proc fibonacci_rec {n} {
        if {$n <= 1} {
            return $n
        }
        return [expr {[fibonacci_rec [expr {$n - 1}]] + [fibonacci_rec [expr {$n - 2}]]}]
    }

    proc greatest_common_divisor_rec {a b} {
        if {$b == 0} {
            return $a
        }
        return [greatest_common_divisor_rec $b [expr {$a % $b}]]
    }

    proc least_common_multiple_rec {a b} {
        if {$a == 0 || $b == 0} {
            return 0
        }
        return [expr {($a / [greatest_common_divisor_rec $a $b]) * $b}]
    }

    proc sum_of_first_n_acc {n} {
        return [sum_of_first_n_acc_help $n 0]
    }

    proc sum_of_first_n_acc_help {current accumulator} {
        if {$current <= 0} {
            return $accumulator
        }
        return [sum_of_first_n_acc_help [expr {$current - 1}] [expr {$current + $accumulator}]]
    }

    proc factorial_acc {n} {
        return [factorial_acc_help $n 1]
    }

    proc factorial_acc_help {current accumulator} {
        if {$current <= 1} {
            return $accumulator
        }
        return [factorial_acc_help [expr {$current - 1}] [expr {$current * $accumulator}]]
    }

    proc fibonacci_acc {n} {
        return [fibonacci_acc_help $n 0 1]
    }

    proc fibonacci_acc_help {position previous current} {
        if {$position <= 0} {
            return $previous
        }
        if {$position == 1} {
            return $current
        }
        return [fibonacci_acc_help [expr {$position - 1}] $current [expr {$previous + $current}]]
    }

    proc greatest_common_divisor_acc {a b} {
        return [greatest_common_divisor_acc_help $a $b]
    }

    proc greatest_common_divisor_acc_help {a b} {
        if {$b == 0} {
            return $a
        }
        return [greatest_common_divisor_acc_help $b [expr {$a % $b}]]
    }

    proc least_common_multiple_acc {a b} {
        if {$a == 0 || $b == 0} {
            return 0
        }
        return [expr {($a / [greatest_common_divisor_acc $a $b]) * $b}]
    }

    proc sum_of_first_n_ite {n} {
        set result 0
        for {set current 1} {$current <= $n} {incr current} {
            incr result $current
        }
        return $result
    }

    proc factorial_ite {n} {
        set result 1
        for {set current 2} {$current <= $n} {incr current} {
            set result [expr {$result * $current}]
        }
        return $result
    }

    proc fibonacci_ite {n} {
        if {$n <= 1} {
            return $n
        }

        set previous 0
        set current 1
        for {set position 2} {$position <= $n} {incr position} {
            set next [expr {$previous + $current}]
            set previous $current
            set current $next
        }
        return $current
    }

    proc greatest_common_divisor_ite {a b} {
        set x $a
        set y $b
        while {$y != 0} {
            set remainder [expr {$x % $y}]
            set x $y
            set y $remainder
        }
        return $x
    }

    proc least_common_multiple_ite {a b} {
        if {$a == 0 || $b == 0} {
            return 0
        }
        return [expr {($a / [greatest_common_divisor_ite $a $b]) * $b}]
    }
}

package provide numbers 1.0
