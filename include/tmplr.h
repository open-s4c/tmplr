/*
 * Copyright (C) 2025 Huawei Technologies Co., Ltd.
 * SPDX-License-Identifier: MIT
 */
#ifndef TMPLR_H
#define TMPLR_H

/**
 * Marks the begin of a template block.
 *
 * Takes a comma-separated list of key value pairs, where values can be lists of
 * the form [[val1;val2;val3]] or single values. For example:
 *
 * ```c
 * $_begin(KEY1 = VALUE1, KEY2 = [[VALUE2; VALUE3]]);
 * KEY1 = KEY2;
 * $_end;
 * ```
 */

#define $_begin(...)

/**
 * Marks the end of a template block.
 */
#define $_end

/**
 * Adds a string to begin or end hook.
 *
 * @param HOOK either begin or end
 *
 * The string argument may contain commas but no parenthesis.
 */
#define $_hook(HOOK, ...)

/**
 * Stops tmplr processing and output.
 *
 * Until the matching $_unmute, all text is discarded and all tmplr command
 * ignored. A muted-block is useful to add includes that help LSP servers.
 */
#define $_mute

/**
 * Restarts tmplr processing output.
 */
#define $_mute

/**
 *  Maps a key K to a value which may contain commas
 */
#define $_map(K, ...)

/**
 * Skips template block iteration.
 *
 * @note This can only be called within $_begin and $_end.
 */
#define $_skip

/**
 * Deletes the line from the template output.
 */
#define $_dl

/**
 * Adds a new line.
 */
#define $_nl

/**
 * Aborts tmplr execution and exits with error code 1.
 */
#define $_abort

/**
 * Makes content uppercase.
 *
 * @note This can only be called within $_begin and $_end.
 */
#define $_upcase(...)

#endif /* TMPLR_H */
