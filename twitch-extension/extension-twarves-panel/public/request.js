/**
 * Module de construction de requêtes vers l'EBS de l'extension
 */
class Request {
	constructor() {
		this.url = ''
		this.token = ''
	}

	init(url, token) {
		this.url = url
		this.token = token
	}

	get(route, params = {}) {
		let queryString = Object.keys(params)
				.map(key => key + '=' + params[key])
				.join('&')


		return this.build('GET', route + (queryString !== '' ? '?' + queryString : ''))
	}

	post(route, params = {}) {
		return this.build('POST', route, params)
	}

	build(method, route, params) {
		let options = {
			method: method,
			headers: {
				Authorization: 'Bearer ' + this.token
			},
			body: JSON.stringify(params)
		}
		
		console.log('[Request]', method, this.url + route)
		console.log(params)
		console.log(options)

		return fetch(this.url + route, options).then(res => res.json())
	}
}