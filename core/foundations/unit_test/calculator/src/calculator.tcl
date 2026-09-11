namespace eval Calculator {
    namespace export addition subtraction multiplication division modulus

    proc addition {a b} {
        return [expr {$a + $b}]
    }

    proc subtraction {a b} {
        return [expr {$a - $b}]
    }

    proc multiplication {a b} {
        if {$b < 0} {
            error "The multiplier must be non-negative"
        }

        set result 0
        for {set count 0} {$count < $b} {incr count} {
            set result [addition $result $a]
        }
        return $result
    }

    proc division {a b} {
        if {$b <= 0} {
            error "The divisor must be positive"
        }

        set dividend $a
        set quotient 0
        while {$dividend >= $b} {
            set dividend [subtraction $dividend $b]
            incr quotient
        }
        return $quotient
    }

    proc modulus {a b} {
        if {$b <= 0} {
            error "The divisor must be positive"
        }

        set quotient [division $a $b]
        set product [multiplication $quotient $b]
        return [subtraction $a $product]
    }
}

package provide calculator 1.0
