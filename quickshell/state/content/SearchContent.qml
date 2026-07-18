// SearchContent.qml - Search content selector
import QtQuick

QtObject {
    id: root
    objectName: "searchContent"
    signal searchQueryChanged(string query)
    signal searchResultsReady()

    property string query: ""
    property list<var> results: []
    property bool isSearching: false
    Component.onCompleted: {
        console.log("SearchContent initialized");
    }

    function setQuery(newQuery) {
        root.query = newQuery;
        root.searchQueryChanged(newQuery);
    }

    function performSearch() {
        if (root.query.length > 0) {
            root.isSearching = true;
            console.log("Searching for:", root.query);
        }
    }

    function clearSearch() {
        root.query = "";
        root.results = [];
        root.isSearching = false;
    }
}
