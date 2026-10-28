/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */

static int topbar = 1; /* -b  option; if 0, mnu appears at bottom */

/* -fn option overrides fonts[0]; default X11 font or font set */
static const char *fonts[] = {
	"Monospace:size=14"
};
static const char *prompt                = NULL; /* -p  option; prompt to the left of input field */
static const char *colors[SchemeLast][2] = {
	/* Highlight backgrounds are inherited from the item state. */
	/*                         fg         bg       */
	[SchemeNorm]          = { "#d8d8d8", "#101010" },
	[SchemeSel]           = { "#d8d8d8", "#34302d" },
	[SchemeSelHighlight]  = { "#ffc799", "#34302d" },
	[SchemeNormHighlight] = { "#ffc799", "#101010" },
	[SchemeOut]           = { "#90b99f", "#101010" },
	[SchemeOutHighlight]  = { "#ffc799", "#101010" },
	[SchemeHp]            = { "#d8d8d8", "#101010" }
};
/* -l option; if nonzero, mnu uses vertical list with given number of lines */
static unsigned int lines = 0;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";
