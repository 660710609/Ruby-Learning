import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["status"]

    async scraping(event) {
        event.preventDefault();
        document.body.classList.toggle('loading')

        this.statusTarget.innerHTML = `
          <div class="overlay">
            <div class="scraping-pop-up-content">
              <div class="loader"></div> <h2 class="mt-4">Loading Scraping...</h2>
              <p>Wait for Data</p>
            </div>
          </div>
        `

        try {
            const response = await fetch('pull', {
                method: 'GET',
                headers: {
                    "Content-Type": "application/json"
                }
            })

            const result = await response.json()
            if (result.success === true) {
                this.statusTarget.innerHTML = `
                  <div class="overlay">
                    <div class="scraping-pop-up-content">
                      <div class="checkmark-circle">
                         <div class="background"></div>
                         <div class="icon"></div>
                      </div>
                      <h2 class="text-success">Scraping Complete</h2>
                      <button class="btn-close" onclick="window.location.href='/'">Close</button>
                    </div>
                  </div>
                `;
            }
        } catch (err) {
            console.log(err)
        }
    }
}