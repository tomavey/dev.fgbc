              <cfparam name="ministriesForFooter" default="#arguments#">
              <cfparam name="aboutItemsArray" default="#getSetting('aboutItemsForFooter')#">
              <div class="shortcode-html">
                <!-- Footer -->
                <div class="g-bg-black-opacity-0_9 g-color-white-opacity-0_8 g-py-60">
                  <div class="container">
                    <div class="row">
                      <!-- Footer Content -->
                      <div class="col-lg-3 col-md-6 g-mb-40 g-mb-0--lg">
                        <div class="u-heading-v2-3--bottom g-brd-white-opacity-0_8 g-mb-20">
                          <h2 class="u-heading-v2__title h6 text-uppercase mb-0">About Us</h2>
                        </div>
                          <ul class="list-unstyled g-mt-minus-10 mb-0">
                            <cfoutput>
                              <cfloop array="#aboutItemsArray#" index="item" >
                                <li class="g-pos-rel g-brd-bottom g-brd-white-opacity-0_1 g-py-10">
                                  <h4 class="h6 g-pr-20 mb-0">
                                    <a class="g-color-white-opacity-0_8 g-color-white--hover" href="#item.link#">#item.name#</a>
                                    <i class="fa fa-angle-right g-absolute-centered--y g-right-0"></i>
                                  </h4>
                                </li>
                              </cfloop>
                            </cfoutput>
                          </ul>
<!---
                        <p>Subscribe below to stay up to date about what is happening within the Charis Fellowship.</p>

                        <div class="input-group border-0">
                          <input class="form-control border-0 rounded-0 g-px-12 g-py-8" type="email" placeholder="Email address">
                          <div class="input-group-addon g-brd-around-none p-0">
                            <button class="btn u-btn-primary rounded-0 g-px-12 g-py-8" type="submit" role="button">Subscribe</button>
                          </div>
                        </div>
--->                        
                      </div>
                      <!-- End Footer Content -->

                      <!-- Footer Content -->
                      <div class="col-lg-3 col-md-6 g-mb-40 g-mb-0--lg">
                        <div class="u-heading-v2-3--bottom g-brd-white-opacity-0_8 g-mb-20">
                          <h2 class="u-heading-v2__title h6 text-uppercase mb-0">CHURCH PLANTING</h2>
                        </div>

                        <nav class="text-uppercase1">
                          <ul class="list-unstyled g-mt-minus-10 mb-0">
                            <cfoutput query="ministriesForFooter.churchPlanting">
                              <li class="g-pos-rel g-brd-bottom g-brd-white-opacity-0_1 g-py-10">
                                <h4 class="h6 g-pr-20 mb-0">
                                  <a class="g-color-white-opacity-0_8 g-color-white--hover" href="#webaddress#" target="_blank">#name#</a>
                                  <i class="fa fa-angle-right g-absolute-centered--y g-right-0"></i>
                                </h4>
                              </li>
                            </cfoutput>
                            <li class="g-pos-rel g-brd-bottom g-brd-white-opacity-0_1 g-py-10">
                              <h4 class="h6 g-pr-20 mb-0">
                                <a class="g-color-white-opacity-0_8 g-color-white--hover" href="/index.cfm?controller=ministries&action=index&category=church+planting+ministries">More Church Planting Ministries</a>
                                <i class="fa fa-angle-right g-absolute-centered--y g-right-0"></i>
                              </h4>
                            </li>
                        </ul>
                        </nav>
                      </div>
                      <!-- End Footer Content -->

                      <!-- Footer Content -->
                      <div class="col-lg-3 col-md-6 g-mb-40 g-mb-0--lg">
                        <div class="u-heading-v2-3--bottom g-brd-white-opacity-0_8 g-mb-20">
                          <h2 class="u-heading-v2__title h6 text-uppercase mb-0">LEADERSHIP TRAINING</h2>
                        </div>

                        <nav class="text-uppercase1">
                          <ul class="list-unstyled g-mt-minus-10 mb-0">
                            <cfoutput query="ministriesForFooter.leadershipTraining">
                              <li class="g-pos-rel g-brd-bottom g-brd-white-opacity-0_1 g-py-10">
                                <h4 class="h6 g-pr-20 mb-0">
                                  <a class="g-color-white-opacity-0_8 g-color-white--hover" href="#webaddress#" target="_blank">#name#</a>
                                  <i class="fa fa-angle-right g-absolute-centered--y g-right-0"></i>
                                </h4>
                              </li>
                            </cfoutput>
                            <li class="g-pos-rel g-brd-bottom g-brd-white-opacity-0_1 g-py-10">
                              <h4 class="h6 g-pr-20 mb-0">
                                <a class="g-color-white-opacity-0_8 g-color-white--hover" href="/index.cfm?controller=ministries&action=index&category=Leadership+Training+Ministries">More Leadership Training Ministries</a>
                                <i class="fa fa-angle-right g-absolute-centered--y g-right-0"></i>
                              </h4>
                            </li>
                          </ul>
                        </nav>
                      </div>
                      <!-- End Footer Content -->

                      <!-- Footer Content -->
                      <div class="col-lg-3 col-md-6 g-mb-40 g-mb-0--lg">
                        <div class="u-heading-v2-3--bottom g-brd-white-opacity-0_8 g-mb-20">
                          <h2 class="u-heading-v2__title h6 text-uppercase mb-0">DOING GOOD FOR THE SAKE OF THE GOSPEL</h2>
                        </div>

                        <nav class="text-uppercase1">
                          <ul class="list-unstyled g-mt-minus-10 mb-0">
                            <cfoutput query="ministriesForFooter.doingGood">
                              <li class="g-pos-rel g-brd-bottom g-brd-white-opacity-0_1 g-py-10">
                                <h4 class="h6 g-pr-20 mb-0">
                                  <a class="g-color-white-opacity-0_8 g-color-white--hover" href="#webaddress#" target="_blank">#name#</a>
                                  <i class="fa fa-angle-right g-absolute-centered--y g-right-0"></i>
                                </h4>
                              </li>
                            </cfoutput>
                            <li class="g-pos-rel g-brd-bottom g-brd-white-opacity-0_1 g-py-10">
                              <h4 class="h6 g-pr-20 mb-0">
                                <a class="g-color-white-opacity-0_8 g-color-white--hover" href="/index.cfm?controller=ministries&action=index&category=Doing+Good">More Doing Good Ministries</a>
                                <i class="fa fa-angle-right g-absolute-centered--y g-right-0"></i>
                              </h4>
                            </li>
                          </ul>
                        </nav>
                      </div>
                      <!-- End Footer Content -->

                      <!-- Footer Content -->
                      <div class="col-lg-12 col-md-12 text-center" style="margin-top:20px">
                          <h3>Communication</h3>

                            <cfoutput query="ministriesForFooter.communication">
                              <a class="g-bg-white-opacity-0_1 g-bg-white-opacity-0_2--hover g-color-white-opacity-0_6" href="#webAddress#">#name#
                              </a>
                              <cfif currentRow NEQ ministriesForFooter.communication.recordCount>
                                &nbsp;&middot;&nbsp;
                              </cfif>
                            </cfoutput>

                            
                      </div>

                      <div class="col-lg-12 col-md-12 text-center" id="socialIcons" style="margin-top:20px">
                        <div class="u-heading-v2-3--bottom g-brd-white-opacity-0_8 g-mb-20">
                          <h2 class="u-heading-v2__title h6 text-uppercase mb-0">Follow Us On...</h2>
                        </div>

                        <ul class="list-inline mb-0">
                          <li class="list-inline-item g-mr-10">
                            <a class="u-icon-v3 u-icon-size--xs g-bg-white-opacity-0_1 g-bg-white-opacity-0_2--hover g-color-white-opacity-0_6" href="https://vimeo.com/charisfellowship" @mouseover='message="Vimeo"' @mouseleave='message="Social Media"'>
                              <i class="fa fa-vimeo"></i>
                            </a>
                          </li>
                          <li class="list-inline-item g-mr-10">
                            <a class="u-icon-v3 u-icon-size--xs g-bg-white-opacity-0_1 g-bg-white-opacity-0_2--hover g-color-white-opacity-0_6" href="https://twitter.com/charischurches" @mouseover='message="Twitter"' @mouseleave='message="Social Media"'>
                              <i class="fa fa-twitter"></i>
                            </a>
                          </li>
                          <li class="list-inline-item g-mr-10">
                            <a class="u-icon-v3 u-icon-size--xs g-bg-white-opacity-0_1 g-bg-white-opacity-0_2--hover g-color-white-opacity-0_6" href="https://www.facebook.com/charischurches/" @mouseover='message="Facebook"' @mouseleave='message="Social Media"'>
                              <i class="fa fa-facebook"></i>
                            </a>
                          </li>
                          <li class="list-inline-item g-mr-10">
                            <a class="u-icon-v3 u-icon-size--xs g-bg-white-opacity-0_1 g-bg-white-opacity-0_2--hover g-color-white-opacity-0_6" href="https://www.youtube.com/channel/UCHpppy8S5akFMz3avHNTQCw" @mouseover='message="Youtube"' @mouseleave='message="Social Media"'>
                              <i class="fa fa-youtube"></i>
                            </a>
                          </li>
                        </ul>
                        {{message}}
                        <p style="text-align:center">Charis Fellowship - 1401 Kings Highway, Winona Lake, Indiana 46590</p>
                      </div>
                      <!-- End Footer Content -->

                    </div>
                  </div>
                </div>
                <!-- End Footer -->

                <!-- Copyright Footer -->
                <footer class="g-bg-gray-dark-v1 g-color-white-opacity-0_8 text-center g-py-20">
                <div class="container">
                    <small class="g-font-size-default g-mr-10 g-mb-10 g-mb-0--md">2017 &copy; Charis Fellowship - All Rights Reserved. Web Design Customized by
                      <a href="https://ericmillercreative.com">Eric Miller Creative</a>
                    </small>
                  </div>
                </footer>
                <!-- End Copyright Footer -->
              </div>

              <script>
                const vueApp = new Vue({
                  el: '#socialIcons',
                  data () {
                    return {
                      message: 'Social Media' 
                    }
                  },
                  methods: {
                    popup(pMessage) {
                      this.message = pMessage
                    }
                  }
                })
                </script>