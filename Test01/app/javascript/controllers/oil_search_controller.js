import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["results"]

  async search(event) {
    event.preventDefault()

    const selectElement = document.getElementById("oil_select")
    let type = selectElement.value

    try {
      this.resultsTarget.innerHTML = '<p class="text-center text-gray-500">กำลังดึงข้อมูล...</p>'

      const response = await fetch('/api/v1/list', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ oilType: type })
      })

      const result = await response.json()

      if (result.success === true) {
        this.renderResults(result.oil)
      } else {
        this.resultsTarget.innerHTML = `<p class="text-red-500">เกิดข้อผิดพลาด: ${result.error}</p>`
      }
    } catch (error) {
      console.error("Error:", error)
      this.resultsTarget.innerHTML = '<p class="text-red-500">ไม่สามารถเชื่อมต่อกับ Server ได้</p>'
    }
  }

  renderResults(data) {
    let html = ""
    if (Array.isArray(data)) {
      data.forEach(group => {
        html += `<div class="sub-grid">`
        html += `<h3 class="font-bold text-blue-700 mt-4">${group.fuel_type}</h3>`
        group.history.forEach(item => {
          html += `
          <span>${item}</span>
        `
        })
        html += `</div>`
      })
    }
    else {
      html += `<div class="sub-grid">`
      html += `<h3>${data.fuel_type}</h3>`
      data.history.forEach(item => {
        html += `
          <span>${item}</span>
        `
      })
      html += `</div>`

    }
    this.resultsTarget.innerHTML = html
  }
}