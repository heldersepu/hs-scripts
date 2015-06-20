/*!
 * UrlHash v1.0.0
 * URL Hash Format Example:
 * #Services(SearchField=Email&SearchText=gmail&status=1,2,3)~CustomerSearch(SearchField=Address&SearchText=Miami)...
 */
(function (factory) {
	if (typeof define === 'function' && define.amd) {
		define(factory);
	} else if (typeof exports === 'object') {
		module.exports = factory();
	} else {
		var _OldUrlHash = window.UrlHash;
		var api = window.UrlHash = factory(window.jQuery);
		api.noConflict = function () {
			window.UrlHash = _OldUrlHash;
			return api;
		};
	}
}(function () {
	function box(values) {
		var result = {};
		values = values.replace(/\)+$/,'')
		values.split('&').forEach( function(value) {
			var p = value.indexOf('=')
			if (p > 0) {
				var items = {};
				value.substr(p+1).split(',').forEach( function(v) {
					if (v.length > 0) items[v] = true;
				});
				result[value.substr(0, p)] = items
			}
		});
		return result;
	}
	function unbox(obj) {
		var result = "";
		for (var group in obj) {
			if (result != "") result += "~";
			result += group + "(";
			var keys = "";
			for (var key in obj[group]) {
				var values = "";
				for (var value in obj[group][key]) {
					if (obj[group][key][value]) {
						if (values != "") values += ",";
						values += value;
					}
				}
				if (values != "") {
					if (keys != "") keys += "&";
					keys += key + "=" + values;
				}
			}
			result += keys +")"
		}
		return result;
	}

	function init (converter) {
		function api() {
			var hash = {};
			if (location.hash != "") {
				var hashGroups = location.hash.substr(1).split('~');
				hashGroups.forEach( function(group) {
					var p = group.indexOf('(')
					if (p > 1) {
						var key = group.substr(0, p);
						hash[key] = box(group.substr(p+1));
					}
				});
			}
			return hash;
		}

		api.get = api;
		api.set = function (group, key, value) {
			var hash = api();
			if (typeof hash[group] == 'undefined')
				hash[group] = {};
			hash[group][key] = {};
			hash[group][key][value] = true;
			location.hash = unbox(hash);
			return hash;
		}

		api.add = function (group, key, value) {
			var hash = api();
			if (typeof hash[group] == 'undefined')
				hash[group] = {};
			if (typeof hash[group][key] == 'undefined')
				hash[group][key] = {};
			hash[group][key][value] = true;
			location.hash = unbox(hash);
			return hash;
		}

		api.del = function (group, key, value) {
			var hash = api();
			try {
				hash[group][key][value] = false;
			} catch(e) {}
			location.hash = unbox(hash);
			return hash;
		};

		api.drop = function (group, key) {
			var hash = api();
			try {
				if (typeof key == 'string')
					delete hash[group][key];
				else delete hash[group];
			} catch(e) {}
			location.hash = unbox(hash);
			return hash;
		};

		return api;
	}

	return init();
}));
