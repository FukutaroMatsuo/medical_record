<template>
  <div class="max-w-md m-auto py-10">
    <div class="text-red" v-if="error">{{ error }}</div>
    <h3 class="font-mono font-regular text-3xl mb-4">Add a new patient</h3>
    <form action="" @submit.prevent="addPatient">
      <div class="mb-6">
        <input class="input"
          autofocus autocomplete="off"
          placeholder="Type an patient name"
          v-model="newPatient.name" />
      </div>
      <input type="submit" value="Add Patient" class="font-sans font-bold px-4 rounded cursor-pointer no-underline bg-green hover:bg-green-dark block w-full py-4 text-white items-center justify-center" />
    </form>

    <hr class="border border-grey-light my-6" />

    <ul class="list-reset mt-4">
      <li class="py-4" v-for="patient in patients" :key="patient.id" :patient="patient">

        <div class="flex items-center justify-between flex-wrap">
          <p class="block flex-1 font-mono font-semibold flex items-center ">
            <svg class="fill-current text-indigo w-6 h-6 mr-2" viewBox="0 0 20 20" width="20" height="20"><title>patient</title><path d="M15.75 8l-3.74-3.75a3.99 3.99 0 0 1 6.82-3.08A4 4 0 0 1 15.75 8zm-13.9 7.3l9.2-9.19 2.83 2.83-9.2 9.2-2.82-2.84zm-1.4 2.83l2.11-2.12 1.42 1.42-2.12 2.12-1.42-1.42zM10 15l2-2v7h-2v-5z"></path></svg>
            {{ patient.name }}
          </p>

          <button class="bg-tranparent text-sm hover:bg-blue hover:text-white text-blue border border-blue no-underline font-bold py-2 px-4 mr-2 rounded"
          @click.prevent="editPatient(patient)">Edit</button>

          <button class="bg-transprent text-sm hover:bg-red text-red hover:text-white no-underline font-bold py-2 px-4 rounded border border-red"
         @click.prevent="removePatient(patient)">Delete</button>
        </div>

        <div v-if="patient == editedPatient">
          <form action="" @submit.prevent="updatePatient(patient)">
            <div class="mb-6 p-4 bg-white rounded border border-grey-light mt-4">
              <input class="input" v-model="patient.name" />
              <input type="submit" value="Update" class=" my-2 bg-transparent text-sm hover:bg-blue hover:text-white text-blue border border-blue no-underline font-bold py-2 px-4 rounded cursor-pointer">
            </div>
          </form>
        </div>
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  name: 'Patients',
  data () {
    return {
      patients: [],
      newPatient: [],
      error: '',
      editedPatient: ''
    }
  },
  created () {
    if (!localStorage.signedIn) {
      this.$router.replace('/')
    } else {
      this.$http.secured.get('/api/v1/patients')
        .then(response => { this.patients = response.data })
        .catch(error => this.setError(error, 'Something went wrong'))
    }
  },
  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },
    addPatient () {
      const value = this.newPatient
      if (!value) {
        return
      }
      this.$http.secured.post('/api/v1/patients/', { patient: { name: this.newPatient.name } })

        .then(response => {
          this.patientts.push(response.data)
          this.newPatient = ''
        })
        .catch(error => this.setError(error, 'Cannot create patient'))
    },
    removePatient (patient) {
      this.$http.secured.delete(`/api/v1/patients/${patient.id}`)
        .then(response => {
          this.patients.splice(this.patients.indexOf(patient), 1)
        })
        .catch(error => this.setError(error, 'Cannot delete patient'))
    },
    editPatient (patient) {
      this.editedPatient = patient
    },
    updatePatient (patient) {
      this.editedPatient = ''
      this.$http.secured.patch(`/api/v1/patients/${patient.id}`, { patient: { title: patient.name } })
        .catch(error => this.setError(error, 'Cannot update patient'))
    }
  }
}
</script>