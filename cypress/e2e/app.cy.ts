describe('App', () => {
  beforeEach(() => {
    cy.visit('/')
  })

  it('should navigate to home page', () => {
    expect(2).to.equal(2)
  })
})

export {}
