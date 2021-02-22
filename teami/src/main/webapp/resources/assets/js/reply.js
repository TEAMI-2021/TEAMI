console.log("Reply Module........");

var replyService = (function() {

	function add(header,token,reply, callback, error) {
		console.log("add reply...............");
//var token = $("meta[name='_csrf']").attr('content');
//var header = $("meta[name='_csrf_header']").attr('content');
		$.ajax({
			type : 'post',
			url : '/replies/new',
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			beforeSend : function(xhr)
                      {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
                          xhr.setRequestHeader(header,token);
                      },
			success : function(result, status, xhr) {
			console.log("success...............");
				if (callback) {
				console.log("success...............");
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		})
	}

//	function getList(param, callback, error) {
//
//		var bno = param.bno;
//		var page = param.page || 1;
//
//		$.getJSON("/replies/pages/" + bno + "/" + page + ".json",
//				function(data) {
//					if (callback) {
//						callback(data);
//					}
//				}).fail(function(xhr, status, err) {
//			if (error) {
//				error();
//			}
//		});
//	}
	
	

	function getList(param, callback, error) {

	    var bno = param.bno;
	    var page = param.page || 1;
	    
	    $.getJSON("/replies/pages/" + bno + "/" + page + ".json",
	        function(data) {
	    	
	          if (callback) {
	            callback(data); // 댓글 목록만 가져오는 경우 
	            //callback(data.replyCnt, data.list); //댓글 숫자와 목록을 가져오는 경우 
	          }
	        }).fail(function(xhr, status, err) {
	      if (error) {
	        error();
	      }
	    });
	  }
function remove(header,token,rno, callback, error) {
		$.ajax({
			type : 'delete',
			url : '/replies/' + rno,
			beforeSend : function(xhr)
                      {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
                          xhr.setRequestHeader(header,token);
                      },
			success : function(deleteResult, status, xhr) {
				if (callback) {
					callback(deleteResult);
				}
			},
			error : function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		});
	}
		function get(rno, callback, error) {

		$.get("/replies/" + rno + ".json", function(result) {

			if (callback) {
				callback(result);
			}

		}).fail(function(xhr, status, err) {
			if (error) {
				error();
			}
		});
	};
	return {
		add : add,
		get : get,
		getList : getList,
		remove : remove,
		//update : update,
		//displayTime : displayTime
	};

})();
