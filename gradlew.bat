/*
 * Copyright (c) 1994, 2013, Oracle and/or its affiliates. All rights reserved.
 * ORACLE PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 *
 *
 *
 *
 *
 *
 *
 *
 *
 *
 *
 *
 *
 *
 *
 *
 *
 *
 *
 *
 */

package java.lang;

import java.lang.annotation.Native;
import java.math.*;


/**
 * The {@code Long} class wraps a value of the primitive type {@code
 * long} in an object. An object of type {@code Long} contains a
 * single field whose type is {@code long}.
 *
 * <p> In addition, this class provides several methods for converting
 * a {@code long} to a {@code String} and a {@code String} to a {@code
 * long}, as well as other constants and methods useful when dealing
 * with a {@code long}.
 *
 * <p>Implementation note: The implementations of the "bit twiddling"
 * methods (such as {@link #highestOneBit(long) highestOneBit} and
 * {@link #numberOfTrailingZeros(long) numberOfTrailingZeros}) are
 * based on material from Henry S. Warren, Jr.'s <i>Hacker's
 * Delight</i>, (Addison Wesley, 2002).
 *
 * @author  Lee Boynton
 * @author  Arthur van Hoff
 * @author  Josh Bloch
 * @author  Joseph D. Darcy
 * @since   JDK1.0
 */
public final class Long extends Number implements Comparable<Long> {
    /**
     * A constant holding the minimum value a {@code long} can
     * have, -2<sup>63</sup>.
     */
    @Native public static final long MIN_VALUE = 0x8000000000000000L;

    /**
     * A constant holding the maximum value a {@code long} can
     * have, 2<sup>63</sup>-1.
     */
    @Native public static final long MAX_VALUE = 0x7fffffffffffffffL;

    /**
     * The {@code Class} instance representing the primitive type
     * {@code long}.
     *
     * @since   JDK1.1
     */
    @SuppressWarnings("unchecked")
    public static final Class<Long>     TYPE = (Class<Long>) Class.getPrimitiveClass("long");

    /**
     * Returns a string representation of the first argument in the
     * radix specified by the second argument.
     *
     * <p>If the radix is smaller than {@code Character.MIN_RADIX}
     * or larger than {@code Character.MAX_RADIX}, then the radix
     * {@code 10} is used instead.
     *
     * <p>If the first argument is negative, the first element of the
     * result is the ASCII minus sign {@