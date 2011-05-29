// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function activateTab(pageId) {
	var tabCtrl = document.getElementById('tabCtrl');
	var pageToActivate = document.getElementById(pageId);
	for ( var i = 0; i < tabCtrl.childNodes.length; i++) {
		var node = tabCtrl.childNodes[i];
		if (node.nodeType == 1) { /* Element */
			node.style.display = (node == pageToActivate) ? 'block' : 'none';
		}
	}
}
