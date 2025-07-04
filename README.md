<a id="x-28REBLOCKS-TYPEAHEAD-DOCS-2FINDEX-3A-40README-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

# reblocks-typeahead - A Reblocks widget implementing typeahead search.

<a id="reblocks-typeahead-asdf-system-details"></a>

## REBLOCKS-TYPEAHEAD ASDF System Details

* Description: A Reblocks widget implementing typeahead search.
* Licence: Unlicense
* Author: Alexander Artemenko <svetlyak.40wt@gmail.com>
* Homepage: [https://40ants.com/reblocks-typeahead/][784a]
* Bug tracker: [https://github.com/40ants/reblocks-typeahead/issues][8267]
* Source control: [GIT][91a7]
* Depends on: [parenscript][7921], [reblocks][184b], [reblocks-lass][28e0], [reblocks-parenscript][c07c], [reblocks-ui][4376]

[![](https://github-actions.40ants.com/40ants/reblocks-typeahead/matrix.svg?only=ci.run-tests)][f8ea]

![](http://quickdocs.org/badge/reblocks-typeahead.svg)

<a id="x-28REBLOCKS-TYPEAHEAD-DOCS-2FINDEX-3A-3A-40INSTALLATION-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

## Installation

You can install this library from Quicklisp, but you want to receive updates quickly, then install it from Ultralisp.org:

```
(ql-dist:install-dist "http://dist.ultralisp.org/"
                      :prompt nil)
(ql:quickload :reblocks-typeahead)
```
<a id="x-28REBLOCKS-TYPEAHEAD-DOCS-2FINDEX-3A-3A-40USAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

## Usage

![](https://storage.yandexcloud.net/40ants-blog-images/reblocks-typeahead-example.gif)

To use this library, you need to inherit your widget from [`reblocks-typeahead:typeahead-widget`][9e7b]
and to provide at least two methods:

* [`reblocks-typeahead:execute-query`][c957] which will respond with data for dropdown
* [`reblocks-typeahead:on-select`][0a41] which will be executed when user has choosen an item from dropdown menu.

See [this example application's code][3c58]
to learn how these methods can be implemented.

<a id="x-28REBLOCKS-TYPEAHEAD-DOCS-2FINDEX-3A-3A-40API-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

## API

<a id="x-28REBLOCKS-TYPEAHEAD-DOCS-2FINDEX-3A-3A-40REBLOCKS-TYPEAHEAD-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### REBLOCKS-TYPEAHEAD

<a id="x-28-23A-28-2818-29-20BASE-CHAR-20-2E-20-22REBLOCKS-TYPEAHEAD-22-29-20PACKAGE-29"></a>

#### [package](e97e) `reblocks-typeahead`

<a id="x-28REBLOCKS-TYPEAHEAD-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-TYPEAHEAD-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28REBLOCKS-TYPEAHEAD-DOCS-2FINDEX-3A-3A-40REBLOCKS-TYPEAHEAD-24TYPEAHEAD-RESULTS-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### TYPEAHEAD-RESULTS

<a id="x-28REBLOCKS-TYPEAHEAD-3ATYPEAHEAD-RESULTS-20CLASS-29"></a>

###### [class](f0f1) `reblocks-typeahead:typeahead-results` (ui-widget)

**Readers**

<a id="x-28REBLOCKS-TYPEAHEAD-3ARESULTS-ITEMS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-TYPEAHEAD-3ATYPEAHEAD-RESULTS-29-29"></a>

###### [reader](d505) `reblocks-typeahead:results-items` (typeahead-results) (= nil)

**Accessors**

<a id="x-28REBLOCKS-TYPEAHEAD-3ARESULTS-ITEMS-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-TYPEAHEAD-3ATYPEAHEAD-RESULTS-29-29"></a>

###### [accessor](d505) `reblocks-typeahead:results-items` (typeahead-results) (= nil)

<a id="x-28REBLOCKS-TYPEAHEAD-DOCS-2FINDEX-3A-3A-40REBLOCKS-TYPEAHEAD-24TYPEAHEAD-WIDGET-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### TYPEAHEAD-WIDGET

<a id="x-28REBLOCKS-TYPEAHEAD-3ATYPEAHEAD-WIDGET-20CLASS-29"></a>

###### [class](d3cb) `reblocks-typeahead:typeahead-widget` (ui-widget)

Base class for custom typeahead widgets.

Define you own widget class based on the [`typeahead-widget`][9e7b]
and also define methods for following generic-functions.

Mandatory:

* [`execute-query`][c957]

Optional:

* [`on-select`][0a41]
* [`on-empty-selection`][d21f]
* [`process-typeahead-choice`][12c7]
* [`update-results`][607c]
* [`hide-results`][7fcf]

**Readers**

<a id="x-28REBLOCKS-TYPEAHEAD-3AINPUT-VALUE-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-TYPEAHEAD-3ATYPEAHEAD-WIDGET-29-29"></a>

###### [reader](2b98) `reblocks-typeahead:input-value` (typeahead-widget) (:value = nil)

<a id="x-28REBLOCKS-TYPEAHEAD-3APLACEHOLDER-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-TYPEAHEAD-3ATYPEAHEAD-WIDGET-29-29"></a>

###### [reader](a3b1) `reblocks-typeahead:placeholder` (typeahead-widget) (:placeholder = nil)

<a id="x-28REBLOCKS-TYPEAHEAD-3ATYPEAHEAD-RESULTS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20REBLOCKS-TYPEAHEAD-3ATYPEAHEAD-WIDGET-29-29"></a>

###### [reader](7800) `reblocks-typeahead:typeahead-results` (typeahead-widget) (= (make-instance 'typeahead-results))

**Accessors**

<a id="x-28REBLOCKS-TYPEAHEAD-3AINPUT-VALUE-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-TYPEAHEAD-3ATYPEAHEAD-WIDGET-29-29"></a>

###### [accessor](2b98) `reblocks-typeahead:input-value` (typeahead-widget) (:value = nil)

<a id="x-28REBLOCKS-TYPEAHEAD-3APLACEHOLDER-20-2840ANTS-DOC-2FLOCATIVES-3AACCESSOR-20REBLOCKS-TYPEAHEAD-3ATYPEAHEAD-WIDGET-29-29"></a>

###### [accessor](a3b1) `reblocks-typeahead:placeholder` (typeahead-widget) (:placeholder = nil)

<a id="x-28REBLOCKS-TYPEAHEAD-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-TYPEAHEAD-3FGenerics-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Generics

<a id="x-28REBLOCKS-TYPEAHEAD-3AEXECUTE-QUERY-20GENERIC-FUNCTION-29"></a>

##### [generic-function](04bc) `reblocks-typeahead:execute-query` widget query

A method for this generic-function should return a list of widgets to be shown in reponse to the given text query.
This method should return a list of widgets.
To make simple widgets out of strings, you can use
[`reblocks/widgets/string-widget:make-string-widget`][e603] function.

<a id="x-28REBLOCKS-TYPEAHEAD-3AHIDE-RESULTS-20GENERIC-FUNCTION-29"></a>

##### [generic-function](c968) `reblocks-typeahead:hide-results` widget

Hides dropdown widget. Call this method from a custom [`on-select`][0a41] or [`on-empty-selection`][d21f] methods.

<a id="x-28REBLOCKS-TYPEAHEAD-3AON-EMPTY-SELECTION-20GENERIC-FUNCTION-29"></a>

##### [generic-function](80ad) `reblocks-typeahead:on-empty-selection` widget query

Called when user entered some query but didn't selected any item, just pressed Enter.

<a id="x-28REBLOCKS-TYPEAHEAD-3AON-SELECT-20GENERIC-FUNCTION-29"></a>

##### [generic-function](e9ab) `reblocks-typeahead:on-select` widget item

Called when user selected an item in the typeahead results.

<a id="x-28REBLOCKS-TYPEAHEAD-3APROCESS-TYPEAHEAD-CHOICE-20GENERIC-FUNCTION-29"></a>

##### [generic-function](e1d6) `reblocks-typeahead:process-typeahead-choice` widget query selected-item-idx

Calls either [`on-select`][0a41] or [`on-empty-selection`][d21f] depending on if user has choosen an item from the dropdown.

<a id="x-28REBLOCKS-TYPEAHEAD-3AUPDATE-RESULTS-20GENERIC-FUNCTION-29"></a>

##### [generic-function](fc72) `reblocks-typeahead:update-results` widget query

Calls [`execute-query`][c957] generic-function and updates the dropdown widget.

<a id="x-28REBLOCKS-TYPEAHEAD-DOCS-2FINDEX-3A-3A-7C-40REBLOCKS-TYPEAHEAD-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28REBLOCKS-TYPEAHEAD-3AFOCUS-IN-20FUNCTION-29"></a>

##### [function](566a) `reblocks-typeahead:focus-in` widget


[784a]: https://40ants.com/reblocks-typeahead/
[c957]: https://40ants.com/reblocks-typeahead/#x-28REBLOCKS-TYPEAHEAD-3AEXECUTE-QUERY-20GENERIC-FUNCTION-29
[7fcf]: https://40ants.com/reblocks-typeahead/#x-28REBLOCKS-TYPEAHEAD-3AHIDE-RESULTS-20GENERIC-FUNCTION-29
[d21f]: https://40ants.com/reblocks-typeahead/#x-28REBLOCKS-TYPEAHEAD-3AON-EMPTY-SELECTION-20GENERIC-FUNCTION-29
[0a41]: https://40ants.com/reblocks-typeahead/#x-28REBLOCKS-TYPEAHEAD-3AON-SELECT-20GENERIC-FUNCTION-29
[12c7]: https://40ants.com/reblocks-typeahead/#x-28REBLOCKS-TYPEAHEAD-3APROCESS-TYPEAHEAD-CHOICE-20GENERIC-FUNCTION-29
[9e7b]: https://40ants.com/reblocks-typeahead/#x-28REBLOCKS-TYPEAHEAD-3ATYPEAHEAD-WIDGET-20CLASS-29
[607c]: https://40ants.com/reblocks-typeahead/#x-28REBLOCKS-TYPEAHEAD-3AUPDATE-RESULTS-20GENERIC-FUNCTION-29
[e603]: https://40ants.com/reblocks/api/#x-28REBLOCKS-2FWIDGETS-2FSTRING-WIDGET-3AMAKE-STRING-WIDGET-20FUNCTION-29
[91a7]: https://github.com/40ants/reblocks-typeahead
[f8ea]: https://github.com/40ants/reblocks-typeahead/actions
[e97e]: https://github.com/40ants/reblocks-typeahead/blob/862510c42b6f62eca39d21b4d3c828b4efbd0d36/src/core.lisp#L1
[c968]: https://github.com/40ants/reblocks-typeahead/blob/862510c42b6f62eca39d21b4d3c828b4efbd0d36/src/core.lisp#L104
[04bc]: https://github.com/40ants/reblocks-typeahead/blob/862510c42b6f62eca39d21b4d3c828b4efbd0d36/src/core.lisp#L115
[566a]: https://github.com/40ants/reblocks-typeahead/blob/862510c42b6f62eca39d21b4d3c828b4efbd0d36/src/core.lisp#L163
[f0f1]: https://github.com/40ants/reblocks-typeahead/blob/862510c42b6f62eca39d21b4d3c828b4efbd0d36/src/core.lisp#L29
[d505]: https://github.com/40ants/reblocks-typeahead/blob/862510c42b6f62eca39d21b4d3c828b4efbd0d36/src/core.lisp#L30
[d3cb]: https://github.com/40ants/reblocks-typeahead/blob/862510c42b6f62eca39d21b4d3c828b4efbd0d36/src/core.lisp#L34
[7800]: https://github.com/40ants/reblocks-typeahead/blob/862510c42b6f62eca39d21b4d3c828b4efbd0d36/src/core.lisp#L35
[a3b1]: https://github.com/40ants/reblocks-typeahead/blob/862510c42b6f62eca39d21b4d3c828b4efbd0d36/src/core.lisp#L37
[2b98]: https://github.com/40ants/reblocks-typeahead/blob/862510c42b6f62eca39d21b4d3c828b4efbd0d36/src/core.lisp#L40
[e9ab]: https://github.com/40ants/reblocks-typeahead/blob/862510c42b6f62eca39d21b4d3c828b4efbd0d36/src/core.lisp#L61
[80ad]: https://github.com/40ants/reblocks-typeahead/blob/862510c42b6f62eca39d21b4d3c828b4efbd0d36/src/core.lisp#L70
[e1d6]: https://github.com/40ants/reblocks-typeahead/blob/862510c42b6f62eca39d21b4d3c828b4efbd0d36/src/core.lisp#L78
[fc72]: https://github.com/40ants/reblocks-typeahead/blob/862510c42b6f62eca39d21b4d3c828b4efbd0d36/src/core.lisp#L93
[8267]: https://github.com/40ants/reblocks-typeahead/issues
[3c58]: https://github.com/40ants/reblocks-typeahead/tree/master/example
[7921]: https://quickdocs.org/parenscript
[184b]: https://quickdocs.org/reblocks
[28e0]: https://quickdocs.org/reblocks-lass
[c07c]: https://quickdocs.org/reblocks-parenscript
[4376]: https://quickdocs.org/reblocks-ui

* * *
###### [generated by [40ANTS-DOC](https://40ants.com/doc/)]
